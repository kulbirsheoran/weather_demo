import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_demo/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future Delayed()async{
    await Future.delayed(Duration(seconds: 3));
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

@override
  void initState() {
    // TODO: implement initState
  Delayed();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.lightBlue,
        body: SafeArea(
          child: Center(
            child: Column(

              children: [
                ClipRRect(borderRadius: BorderRadius.circular(500),
                    child: Image.asset('assets/images/clouds.png')

                ),
                const SizedBox(height: 20,),
                const Text('Weather App',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
                const SizedBox(height: 20,),
                const Text('Made By .....'),

              ],
            ),
          ),
        )
    );
  }
}
