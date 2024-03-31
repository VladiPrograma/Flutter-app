import 'package:flutter/material.dart';

import '../core/utils/navigation_service.dart';
import '../init_dependencies.dart';
import 'my_app.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initData()async{
    await initDependencies();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(NavigationService.navigatorKey.currentContext!).push(
      MaterialPageRoute(builder: (context) => const MyApp()),
    );

  }
  @override
  void initState() {

    super.initState();
    initData();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(body: Center(child: Image.asset("assets/ic_launcher.png"),),);
  }
}
