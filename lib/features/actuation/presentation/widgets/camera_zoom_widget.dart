import 'package:cicero_app/core/utils/camera_utils.dart';
import 'package:cicero_app/features/actuation/data/models/camera_status_model.dart';
import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraZoomWidget extends StatelessWidget {
  const CameraZoomWidget({Key? key, required this.cameraStatusModel}) : super(key: key);

  final CameraStatusModel cameraStatusModel;
  @override
  Widget build(BuildContext context) {
    return                     Row(
      children: [
        //@Note Zoom
        Expanded(
          child: Slider(
            value: cameraStatusModel.currentZoom,
            min: cameraStatusModel.minAvailableZoom,
            max: cameraStatusModel.maxAvailableZoom,
            activeColor: Colors.white,
            inactiveColor: Colors.white30,
            onChanged: (value) async {
              context.read<CameraBloc>() .add(CameraZoomEvent(zoomLevel: value));
            },
          ),
        ),
        //@Note Zoom
        Padding(
          padding:
          const EdgeInsets.only(right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius:
              BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${cameraStatusModel.currentZoom
                    .toStringAsFixed(1)}x',
                style: const TextStyle(
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    )
    ;
  }
}
