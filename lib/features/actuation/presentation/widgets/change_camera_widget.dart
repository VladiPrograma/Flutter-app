import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeCameraWidget extends StatelessWidget {
  const ChangeCameraWidget({Key? key,required this.isRecording}) : super(key: key);

  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<CameraBloc>().add(SwitchCameraEvent());
        bool wasRecording = false;
        // if(_isRecordingInProgress){
        //   File? videoFile = await endAndSaveVideo();
        //   if(videoFile!= null){
        //     allFileList.add(videoFile);
        //   }
        //   if(!controller!.value.isRecordingPaused){
        //     wasRecording = true;
        //   }
        // }
        // setState(() {
        //   _isCameraInitialized = false;
        // });
        // await onNewCameraSelected(cameras[_isRearCameraSelected ? 1 : 0]);
        // setState(() {
        //   _isRearCameraSelected =
        //   !_isRearCameraSelected;
        // });
        //
        // if(wasRecording){
        //   await startVideoRecording();
        // }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.circle,
            color: Colors.black38,
            size: 60,
          ),
          Icon(
            isRecording
                ? Icons.camera_front
                : Icons.camera_rear,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }
}
