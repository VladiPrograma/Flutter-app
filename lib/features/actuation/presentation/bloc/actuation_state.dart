part of 'actuation_bloc.dart';

//
//
@immutable
abstract class ActuationState{
}
abstract class ActuationActionState extends ActuationState{
}
 class ActuationSaveSuccess extends ActuationActionState{
}


final class CameraInitial extends ActuationState{
  final CameraStatusModel cameraStatusModel;

  CameraInitial(this.cameraStatusModel);
}
final class SwitchingCamera extends ActuationState{
  final CameraStatusModel cameraStatusModel;

  SwitchingCamera(this.cameraStatusModel);
}

final class CameraInitialize extends ActuationState{
  final CameraStatusModel cameraStatusModel;

  CameraInitialize(this.cameraStatusModel);
}


final class CameraState extends ActuationState{
  final CameraStatusModel cameraStatusModel;
  final CameraController cameraController;

  CameraState({required this.cameraStatusModel,required this.cameraController, });
}

final class ActuationSaveState extends CameraState{
  ActuationSaveState({required super.cameraStatusModel, required super.cameraController});

}



final class CameraRecordingSuccess extends ActuationState {


}

final class CameraLoading extends ActuationState {}

final class CameraFailure extends ActuationState {
  final String error;
  CameraFailure(this.error);
}


