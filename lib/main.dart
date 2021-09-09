import 'package:flutter/material.dart';
import 'package:movie_app/pages/home.dart';


void main()=> runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context)=> Home()
  },
));

