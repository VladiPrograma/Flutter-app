import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:cicero_app/core/error/failures.dart';
import 'package:cicero_app/core/utils/camera_utils.dart';
import 'package:cicero_app/core/utils/my_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../data/models/camera_status_model.dart';
import '../../domain/entities/actuation.dart';
part 'actuation_event.dart';
part 'actuation_state.dart';

class CameraBloc extends Bloc<CameraEvent, ActuationState> {
  CameraController? cameraController;
  VideoPlayerController? videoController;
  Timer? _timer;
  // Initial values


  List<String> allFileList = [];
  final List<CameraDescription> cameras;
  int _miliseconds = 0;
  CameraStatusModel cameraStatusModel=CameraStatusModel();

  CameraBloc( {this.cameraController,required this.cameras,}) : super(CameraInitial(CameraStatusModel())) {
    on<InitializeCamera>(_initializeCamera);
    on<StartRecordingEvent>(_startRecordingButtonClickedEvent);
    on<StopRecordingEvent>(_stopRecordingEvent);
    on<CameraZoomEvent>(_cameraZoomEvent);
    on<CameraExposureEvent>(_cameraExposureEvent);
    on<SwitchCameraEvent>(_switchCameraEvent);
    on<OnViewFinderTapEvent>(_onViewFinderTapEvent);
    on<PauseResumeRecordingEvent>(_pauseResumeRecordingEvent);
  }

  void startTimer() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      _miliseconds++;
    });
  }

  void resetCameraValues() {
    cameraStatusModel.currentExposure=1.0;
    cameraStatusModel.currentZoom=1.0;
  }

  Future<void> onNewCameraSelected() async {

      cameraController = CameraController(
      cameras[cameraStatusModel.isRearCameraSelected?0:1],
      ResolutionPreset.high,
    );
    resetCameraValues();
      await cameraController?.initialize();

    await Future.wait([
      cameraController
            !.getMinExposureOffset()
            .then((value) => cameraStatusModel.minAvailableExposureOffset = value),
      cameraController
        !.getMaxExposureOffset()
            .then((value) => cameraStatusModel.maxAvailableExposureOffset = value),
      cameraController
        !.getMaxZoomLevel()
            .then((value) => cameraStatusModel.maxAvailableZoom = value),
      cameraController
        !.getMinZoomLevel()
            .then((value) => cameraStatusModel.minAvailableZoom = value),
      ]);



  }



  FutureOr<void> _initializeCamera(InitializeCamera event, Emitter<ActuationState> emit) async{
    try {
     cameraStatusModel.isCameraPermissionGranted=await CameraUtils.getPermissionStatus();
     await onNewCameraSelected();
     emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));
     print("camera initialized");
    } on CameraException catch (e) {
    print('Error initializing the camera: $e');
    emit(CameraFailure("Error initializing the camera: $e"));
    }
  }

  FutureOr<void> _startRecordingButtonClickedEvent(
      StartRecordingEvent event, Emitter<ActuationState> emit) async {
    if(!cameraStatusModel.isCameraPermissionGranted){
      cameraStatusModel.isCameraPermissionGranted=  await CameraUtils.getPermissionStatus();

       }
    if (cameraController!.value.isRecordingVideo && !cameraStatusModel.isCameraPermissionGranted) {
      // A recording has already started, do nothing.
      return;
    }

    try {
      await cameraController!.startVideoRecording();
      startTimer();
      cameraStatusModel.isRecording=true;
      emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
      emit(CameraFailure("Error starting to record video: $e"));
    }
  }

  FutureOr<void> _stopRecordingEvent(
      StopRecordingEvent event, Emitter<ActuationState> emit) async {
      if (!cameraController!.value.isRecordingVideo) {
        // Recording is already is stopped state
        return null;
      }
_timer?.cancel();
      try {
        XFile file = await cameraController!.stopVideoRecording();
        cameraStatusModel.isRecording=false;
        _miliseconds=0;
        allFileList.add(file.path);
emit(ActuationSaveState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));
        await CameraUtils.mergeVideos(allFileList);
        allFileList.clear();
        emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));
        emit(ActuationSaveSuccess());
      } on CameraException catch (e) {
        print('Error stopping video recording: $e');
        emit(CameraFailure('Error stopping video recording: $e'));
      }

  }



  FutureOr<void> _cameraZoomEvent(
      CameraZoomEvent event, Emitter<ActuationState> emit) async {
    cameraStatusModel.currentZoom=event.zoomLevel;
    await cameraController!.setZoomLevel(cameraStatusModel.currentZoom);
    cameraStatusModel.isRecording=cameraController!.value.isRecordingVideo;
    emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));
  }

  FutureOr<void> _cameraExposureEvent(
      CameraExposureEvent event, Emitter<ActuationState> emit) async {
    cameraStatusModel.currentExposure=event.exposureLevel;
    cameraStatusModel.isRecording=cameraController!.value.isRecordingVideo;
    await cameraController!.setExposureOffset(cameraStatusModel.currentExposure);
    emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));

  }

  FutureOr<void> _switchCameraEvent(
      SwitchCameraEvent event, Emitter<ActuationState> emit) async {
    try {
      cameraStatusModel.isRearCameraSelected=!cameraStatusModel.isRearCameraSelected;

      if(cameraStatusModel.isRecording && (cameraController!.value.isRecordingVideo||cameraController!.value.isRecordingPaused)){
      final recFile=await cameraController!.stopVideoRecording();
      allFileList.add(recFile.path);
      // emit(SwitchingCamera(cameraStatusModel));
      // await cameraController?.dispose();
      //
      //  await onNewCameraSelected();
      await cameraController?.setDescription(cameras[cameraStatusModel.isRearCameraSelected?0:1]);
      // emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));
      await cameraController?.startVideoRecording();
      }else{
        await cameraController?.setDescription(cameras[cameraStatusModel.isRearCameraSelected?0:1]);

        // await onNewCameraSelected();
        // emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));

      }
    } on Exception catch (e) {
      print("Change Camera error: $e");
      emit(CameraFailure("Change Camera error: $e"));
    }
  }



  FutureOr<void> _onViewFinderTapEvent(OnViewFinderTapEvent event, Emitter<ActuationState> emit) async{
    if (cameraController == null) {
      return;
    }

    final offset = Offset(
      event.details.localPosition.dx / event.constraints.maxWidth,
      event.details.localPosition.dy / event.constraints.maxHeight,
    );
    cameraController!.setExposurePoint(offset);
    cameraController!.setFocusPoint(offset);
  }



  FutureOr<void> _pauseResumeRecordingEvent(PauseResumeRecordingEvent event, Emitter<ActuationState> emit) async{
    try {
      if(cameraController!.value.isRecordingPaused){
        await cameraController!.resumeVideoRecording();
      startTimer();
      }else{
        await cameraController!.pauseVideoRecording();
        _timer?.cancel();
      }
      emit(CameraState(cameraStatusModel: cameraStatusModel, cameraController: cameraController!));
    } on CameraException catch (e) {
      print('Error ${cameraController!.value.isRecordingPaused?"pausing":"resuming"} video recording: $e');
      emit(CameraFailure('Error ${cameraController!.value.isRecordingPaused?"pausing":"resuming"} video recording: $e'));

    }
  }



}
