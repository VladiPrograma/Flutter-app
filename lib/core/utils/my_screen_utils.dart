import 'package:flutter/cupertino.dart';

class MyScreenUtils{
  static double width=0,height=0;
  static Orientation orientation=Orientation.portrait;

  static void setScreenUtils(MediaQueryData mediaQueryData){
    width=mediaQueryData.size.width;
    height=mediaQueryData.size.height;
    orientation=mediaQueryData.orientation;
  }
}