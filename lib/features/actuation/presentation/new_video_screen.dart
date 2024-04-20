import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cicero_app/core/utils/camera_utils.dart';
import 'package:cicero_app/core/utils/my_screen_utils.dart';
import 'package:cicero_app/features/actuation/data/models/camera_status_model.dart';
import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:cicero_app/features/actuation/presentation/widgets/camera_exposure_widget.dart';
import 'package:cicero_app/features/actuation/presentation/widgets/camera_top_bar.dart';
import 'package:cicero_app/features/actuation/presentation/widgets/camera_zoom_widget.dart';
import 'package:cicero_app/features/actuation/presentation/widgets/change_camera_widget.dart';
import 'package:cicero_app/features/actuation/presentation/widgets/comment_widget.dart';
import 'package:cicero_app/features/actuation/presentation/widgets/pause_resume_camera_widget.dart';
import 'package:cicero_app/features/actuation/presentation/widgets/play_stop_button_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/show_snackbar.dart';


class NewCameraScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => NewCameraScreen());
  @override
  _NewCameraScreenState createState() => _NewCameraScreenState();
}

class _NewCameraScreenState extends State<NewCameraScreen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    CameraUtils.getPermissionStatus().then((value) {
      context.read<CameraBloc>().add(InitializeCamera());
    });

    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  double _getAspectRatio(CameraController controller) {
    double aspectRatio = controller.value.aspectRatio;
    if (controller.value.isRecordingVideo) {
      return aspectRatio;
    }
    if (SizerUtil.orientation == Orientation.portrait) {
      aspectRatio = 1 / aspectRatio;
    }
    return aspectRatio;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CameraBloc cameraBloc=context.read<CameraBloc>();
     final CameraController? cameraController =cameraBloc.cameraController ;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      cameraBloc.add(InitializeCamera());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   MyScreenUtils.setScreenUtils(MediaQuery.of(context));
    return SafeArea(
      child: BlocConsumer<CameraBloc, ActuationState>(
        listener: (context, state) {
          if (state is ActuationSaveSuccess) {
            showSnackBar(context, "Actuation saved successfully.");
          }

        },
        listenWhen: (previous, current) => current is ActuationActionState,
        buildWhen: (previous, current) => current is! ActuationActionState,
        builder: (context, state) {
          if (state is CameraLoading || state is CameraInitial) {
            return const Center(
              child: Text('loading...',style: TextStyle(decoration: TextDecoration.none),),
            );
          }else if(state is CameraFailure){
            return  Center(
              child: Text(state.error),
            );
          }
          CameraStatusModel cameraStatusModel =
              (state as CameraState).cameraStatusModel;

          return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Column(
                    children: [
                       const CameraTopBarWidget(),
                      //You cam fill the data here
                      const  SizedBox(height: 50,),
                      Center(
                        child: SizedBox(
                          width: MyScreenUtils.width,
                          height: MyScreenUtils.height- (MyScreenUtils.orientation==Orientation.portrait? 200:170),
                          child: AspectRatio(
                            aspectRatio: _getAspectRatio(state.cameraController),
                            child: CameraPreview(
                              state.cameraController,
                              child: LayoutBuilder(builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTapDown: (details) {
                                    context.read<CameraBloc>().add(
                                        OnViewFinderTapEvent(
                                            details: details,
                                            constraints: constraints));
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      //You cam fill the data here

                      const SizedBox(height: 50,),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      2.w,
                      7.h,
                      2.w,
                      2.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2.w, top: 0.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${state.cameraStatusModel.currentExposure.toStringAsFixed(1)}x',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        //@Note exposure
                        CameraExposureWidget(
                            cameraStatusModel: cameraStatusModel),
                        CameraZoomWidget(
                          cameraStatusModel: cameraStatusModel,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //@Note change camera
                            ChangeCameraWidget(
                                isRecording:
                                    state.cameraStatusModel.isRecording),
                            //@Note Pause video recording
                            PauseResumeCameraWidget(
                              state: state,
                            ), //@Note Play and Stop Button
                            PlayStopButtonWidget(state: state),
                            //@Note Add Coments
                            CommentWidget(state: state),
                            //@Note Free Space
                            Icon(
                              Icons.circle,
                              color: Colors.black38.withOpacity(0),
                              size: 60,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
