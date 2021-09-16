import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

Future getShowing() async {
  MovieService instance = MovieService();

  var result = await instance.getShowing();
  print(result);
  // return result;
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // getShowing();
    return Container();
  }
}
