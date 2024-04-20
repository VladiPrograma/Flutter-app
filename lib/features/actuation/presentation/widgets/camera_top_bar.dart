import 'package:cicero_app/core/utils/my_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CameraTopBarWidget extends StatelessWidget {
  const CameraTopBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return                   Container(
      alignment: Alignment.centerLeft,
        width: MyScreenUtils.width,
        height: MyScreenUtils.orientation==Orientation.portrait? 100:70,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage('assets/ic_launcher.png'),
            // image: AssetImage('lib/assets/logos/logo_CLIENT.png'),
            fit: BoxFit.contain,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD9805F),
              Color(0xFFF2C49A),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MyScreenUtils.width*0.2,
          ),
          child: Text(
            'Diputacion Granada',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp),
          ),
        ));
    ;
  }
}
