import 'package:cicero_app/core/utils/my_screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        width: MyScreenUtils.width,
        height: MyScreenUtils.height,
        alignment: Alignment.center,
        color: Colors.black54,
        child: Center(child: LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 60),),
      ),
    );
  }
}
