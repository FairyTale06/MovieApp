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

  Widget searhBar(){
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.blue,
          labelText: 'SearchBar...'
        ),
      )
    );
  }
class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    // getSearch();
    return ListView(
      children: [
        searhBar()
      ],
    );
  }
}
