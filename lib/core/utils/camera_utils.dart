import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraUtils {
  static double minAvailableExposureOffset = 0.0;
  static double maxAvailableExposureOffset = 0.0;
  static double minAvailableZoom = 1.0;
  static double maxAvailableZoom = 1.0;
  static Future<bool> getPermissionStatus() async {
    var sstatus = await Permission.storage.request();

    var status = await Permission.camera.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<File?> saveVideo(XFile file) async {
    File videoFile = File(file.path);
    int currentUnix = DateTime.now().millisecondsSinceEpoch;
    final directory = await getApplicationDocumentsDirectory();
    String fileFormat = videoFile.path.split('.').last;
    return await videoFile.copy(
      '${directory.path}/$currentUnix.$fileFormat',
    );
  }

  static Future<String> generateOutputPath() async {
    Directory? appDocumentsDirectory = await getDownloadsDirectory();
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String outputPath =
        '${appDocumentsDirectory?.path}/merged_video_$timeStamp.mp4';
    print("Outout Download: $outputPath");
    return outputPath;
  }

  static String replaceFileName(String path, String newFileName) {
    File file = File(path);
    String directory = file.parent.path;
    return '$directory/$newFileName';
  }

  static Future<String> rotateVideo(String path) async {
    FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
    String tempFilePath = await generateOutputPath();

    try {

      final int rc = await flutterFFmpeg.execute(
          '-i $path -vf "transpose=1" -c:a copy $tempFilePath');
      return tempFilePath;
    } catch (e) {
      print('Error rotating video: $e');
      return path;
    }
  }
  static Future<String> rotateVideo2(String path, String path2) async {
    FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
    String tempFilePath = await generateOutputPath();
    String command = 'ffmpeg -i $path -i $path2 -filter_complex "[1:v]transpose=1[v1];[0:v][v1]concat=n=2:v=1:a=0[outv]" -map "[outv]" -c:v libx264 -c:a aac $tempFilePath';
    int result = await flutterFFmpeg.execute(command);
    if (result == 0) {
      print('Videos concatenated and second video rotated successfully.');
    } else {
      print('Failed to concatenate and rotate second video. Error code: $result');
    }
    return tempFilePath;
  }

  static Future<void> deleteFiles(List<String> filePaths) async {
    for (final path in filePaths) {
      try {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
          print('Deleted file: $path');
        } else {
          print('File not found: $path');
        }
      } catch (e) {
        print('Error deleting file: $path');
        print(e);
      }
    }
  }
  static Future<void> mergeVideos(List<String> videoPaths) async {
     if(videoPaths.isEmpty||videoPaths.length==1) return;
    FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
    for (int i = 0; i < videoPaths.length; i++) {
        videoPaths[i] = (await rotateVideo(videoPaths[i]));
    }

    String outputPath = await generateOutputPath();
    String fileListPath =
        '${(await getTemporaryDirectory()).path}/fileList_${DateTime.now().millisecondsSinceEpoch}.txt';
    File fileList = File(fileListPath);
    await fileList
        .writeAsString(videoPaths.map((path) => 'file \'$path\'').join('\n'));
    String command =
        '-f concat -safe 0 -i $fileListPath -c copy -metadata:s:v:0 rotate=90 $outputPath';
    await flutterFFmpeg.execute(command);
    deleteFiles(videoPaths);
  }

}
