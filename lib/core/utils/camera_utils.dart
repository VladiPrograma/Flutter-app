

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraUtils{
  static  double minAvailableExposureOffset = 0.0;
  static  double maxAvailableExposureOffset = 0.0;
  static  double minAvailableZoom = 1.0;
  static  double maxAvailableZoom = 1.0;
 static  Future<bool> getPermissionStatus() async {
   var sstatus=await Permission.storage.request();

   var status = await Permission.camera.request();
    if (status.isGranted) {

      return true;
    } else {
      return false;
    }
  }

 static Future<File?> saveVideo(XFile file) async{
   File videoFile = File(file.path);
   int currentUnix = DateTime.now().millisecondsSinceEpoch;
   final directory = await getApplicationDocumentsDirectory();
   String fileFormat = videoFile.path.split('.').last;
   return await videoFile.copy(
     '${directory.path}/$currentUnix.$fileFormat',
   );
 }
  static Future<String> generateOutputPath() async {
    // Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Directory? appDocumentsDirectory = await getDownloadsDirectory();
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String outputPath =
        '${appDocumentsDirectory?.path}/merged_video_$timeStamp.mp4';
    print("Outout Download: $outputPath");
    return outputPath;
  }

  // static Future rotateVideo(String path,bool isRearCamera)async{
  //  if(isRearCamera)return;
  //   String outputPath = await generateOutputPath();
  //   FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
  //   String command="-i $path -vf rotate=PI:bilinear=0,format=yuv420p \\ -metadata:s:v rotate=0 -codec:v libx264 -codec:a copy $path";
  //   // String command="-y -i $path -c:a aac -c:v h264 $path";
  // await  flutterFFmpeg.execute(command);
  // }

  static Future<void> mergeVideos(List<String> videoPaths) async {
    // VideoHelper.showInSnackBar('Videos merged Start', context);
    if(videoPaths.isEmpty||videoPaths.length==1) return;
    String outputPath = await generateOutputPath();
    FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();

    // Create a text file containing the paths of the videos to concatenate
    String fileListPath =
        '${(await getTemporaryDirectory()).path}/fileList.txt';
    File fileList = File(fileListPath);
    await fileList
        .writeAsString(videoPaths.map((path) => 'file \'$path\'').join('\n'));


    // Run FFmpeg command to concatenate videos
    String command = '-f concat -safe 0 -i $fileListPath -c copy $outputPath';

    await flutterFFmpeg.execute(command).then((value) {
      if (value == 0) {
        print("OutPut Path : $outputPath");
        // VideoHelper.showInSnackBar('Videos merged successfully', context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => VideoPlayerScreen(
        //           videoFile: XFile(outputPath),
        //         )));
      } else {
        // VideoHelper.showInSnackBar(
        //     'Error merging videos  ::::: returnCode=== $value ', context);
      }
    });
  }


}