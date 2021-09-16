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
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Column(
            children: [
              Text(
                'My Movie App',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(170.0),
                child: Column(
                  children: [
                    Text('Powered By: ',
                    style: TextStyle(
                      fontSize: 17
                    ),),
                    Image.asset('assets/logo.jpg',
                    ),
                    Text('TMDB',
                    style: TextStyle(
                      fontSize: 24
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


