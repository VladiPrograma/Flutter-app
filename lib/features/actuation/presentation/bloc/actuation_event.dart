part of 'actuation_bloc.dart';

@immutable
sealed class CameraEvent {
  const CameraEvent();
}

final class StartRecordingEvent extends CameraEvent{

}
final class InitializeCamera extends CameraEvent{

}
final class StopRecordingEvent extends CameraEvent{

}
final class PauseResumeRecordingEvent extends CameraEvent{

}

final class SwitchCameraDuringRecordingEvent extends CameraEvent{

}final class SwitchCameraEvent extends CameraEvent{

}
final class OnViewFinderTapEvent extends CameraEvent{
  final TapDownDetails details;final  BoxConstraints constraints;

  const OnViewFinderTapEvent({
    required this.details,
    required this.constraints,
  });
}

final class CameraZoomEvent extends CameraEvent{
  final double zoomLevel;

  const CameraZoomEvent({required this.zoomLevel});


}
final class CameraExposureEvent extends CameraEvent{
  final double exposureLevel;

  const CameraExposureEvent({required this.exposureLevel});

}



