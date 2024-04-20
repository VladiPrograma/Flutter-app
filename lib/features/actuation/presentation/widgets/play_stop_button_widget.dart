import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PlayStopButtonWidget extends StatelessWidget {
  const PlayStopButtonWidget({super.key,required this.state});
final CameraState state;
  @override
  Widget build(BuildContext context) {
    return                                   InkWell(
      onTap: () async {
        if (state.cameraController.value.isRecordingVideo) {
          context.read<CameraBloc>().add(StopRecordingEvent());
          // Navigator.push( context,
          //   MaterialPageRoute(builder: (context) => VideoPage(filePath: videoFile!.path)),
          // );
        } else {
          context.read<CameraBloc>().add(StartRecordingEvent());
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.circle,
            color: Colors.white,
            size: 80,
          ),
          Icon(
            Icons.circle,
            color: state.cameraStatusModel.isCameraPermissionGranted
                ? state.cameraStatusModel.isRecording
                ? Colors.red
                : Colors.green
                : Colors.grey,
            size: 65,
          ),
          state.cameraStatusModel.isRecording
              ? const Icon(
            Icons.stop_rounded,
            color: Colors.white,
            size: 32,
          )
              : const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 32),
        ],
      ),
    )
    ;
  }
}
