import 'package:flutter/material.dart';
import 'package:movie_app/pages/menu.dart';
import 'package:movie_app/pages/detail.dart';
import 'dart:async';


void main()=> runApp(MaterialApp(
  home: SplashScreen(),
  routes: {
    '/home' : (context)=> Home(),
    '/detail' : (context) =>  Detail()
  },
));

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState(){
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.blue,
                  Color(0xff27319c),
                  Colors.black
                ]
            )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(66.0),
            child: ClipOval(
              // borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('assets/Moviery.png', fit: BoxFit.cover,),
            )
          ),
        ),
      ),
    );
  }
}


