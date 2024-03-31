import 'package:flutter/material.dart';
class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (v){},
      child: Scaffold(body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_outlined,color: Colors.white,size: 100,),
          const SizedBox(height: 20,),
          const Text("Please connect to internet", style: TextStyle(color: Colors.white,fontSize: 24),)

        ],),
      ),),
    );
  }
}
