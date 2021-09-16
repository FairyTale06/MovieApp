import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

Future getSearch() async {
  MovieService instance = MovieService();

  var result = await instance.getSearch('iron man');
  print(result);
  // return result;
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    getSearch();
    return Container();
  }
}
