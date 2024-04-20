class CameraStatusModel{
  double currentZoom,currentExposure,
     minAvailableExposureOffset,
     maxAvailableExposureOffset ,
     minAvailableZoom ,
     maxAvailableZoom ;
  bool isRecording,isPaused,isRearCameraSelected,isCameraPermissionGranted;

  CameraStatusModel({
     this.currentZoom=1.0,
     this.currentExposure=1.0,
     this.minAvailableExposureOffset=1.0,
     this.maxAvailableExposureOffset=1.0,
     this.minAvailableZoom=1.0,
     this.maxAvailableZoom=1.0,
     this.isRecording=false,
     this.isPaused=false,
     this.isRearCameraSelected=true,
    this.isCameraPermissionGranted=true
  });
}