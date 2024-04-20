import 'package:cicero_app/core/utils/camera_utils.dart';
import 'package:cicero_app/features/actuation/data/models/camera_status_model.dart';
import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraExposureWidget extends StatelessWidget {
  const CameraExposureWidget({Key? key, required this.cameraStatusModel}) : super(key: key);

  final CameraStatusModel cameraStatusModel;
  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        child: RotatedBox(
          quarterTurns: 3,
          child: SizedBox(
            height: 60,
            child: Slider(
              value: cameraStatusModel.currentExposure,
              min: cameraStatusModel.minAvailableExposureOffset,
              max: cameraStatusModel.maxAvailableExposureOffset,
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              onChanged: (value) async {
                context.read<CameraBloc>() .add(CameraExposureEvent( exposureLevel: value));
              },
            ),
          ),
        ),
      )

    ;
  }
}
