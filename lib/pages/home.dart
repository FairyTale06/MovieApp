import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:movie_app/movie.dart';
import 'package:movie_app/services/movie_service.dart';

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

  Future<List<MovieService>> futureData;

  int movieID = 550;
  String APIKEY = '2a40536ee239d94cf345668ce6266a60';

  // Future<void> getMovie() async {
  //   try{
  //     Response response;
  //     Dio dio = new Dio();
  //     response = await dio.get('https://api.themoviedb.org/3/movie/$movieID?api_key=$APIKEY');
  //     print(response.data["title"]);
  //   }catch(e){
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('My Movie App'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: FutureBuilder <List<MovieService>>(
            future: futureData,
            builder: (context, snapshot){
              if(snapshot.hasData){
                List<MovieService> data = snapshot.data;
                return ListView.builder(
                    itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Text('sdfsdf')
                          ],
                        ),
                      );
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),
        )
    );
  }
}