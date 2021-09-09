import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:movie_app/movie.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int number = 0;
  List<Movie> movies = [
    Movie(name: 'Oscar', desc: 'Soft'),
    Movie(name: 'Oscar', desc: 'Soft'),
    Movie(name: 'Oscar', desc: 'Soft'),
  ];

  int movieID = 550;
  String APIKEY = '2a40536ee239d94cf345668ce6266a60';

  Future<void> getMovie() async {
    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.get('https://api.themoviedb.org/3/movie/$movieID?api_key=$APIKEY');
      print(response.data["title"]);
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    // getMovie();
    return Scaffold(
        appBar: AppBar(
          title: Text('My Movie App'),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index){
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      title: Text(movies[index].name),
                      subtitle: Text(movies[index].desc),
                    ),
                  )
              );
            }
        )
    );
  }
}