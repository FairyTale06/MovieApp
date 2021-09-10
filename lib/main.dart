import 'package:flutter/material.dart';
import 'package:movie_app/pages/home.dart';
import 'package:movie_app/pages/detail.dart';


void main()=> runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context)=> Home(),
    '/detail' : (context) =>  Detail()
  },
));

