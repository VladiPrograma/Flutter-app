import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PauseResumeCameraWidget extends StatelessWidget {
  const PauseResumeCameraWidget({Key? key, required this.state})
      : super(key: key);
  final CameraState state;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<CameraBloc>().add(PauseResumeRecordingEvent());
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            color: state.cameraStatusModel.isRecording
                ? Colors.black38
                : Colors.black38.withOpacity(0),
            size: 60,
          ),
          state.cameraStatusModel.isRecording
              ? state.cameraController.value.isRecordingPaused
                  ? const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    )
                  : const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 30,
                    )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
