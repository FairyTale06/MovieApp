import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_list.dart';
import 'package:movie_app/services/movie_service.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  List<MovieList> movies = [
    MovieList(name: 'Oscar', desc: 'Soft'),
    MovieList(name: 'Oscar', desc: 'Soft'),
    MovieList(name: 'Oscar', desc: 'Soft'),
  ];

  Future<String> movieList;

  int movieID = 550;

  Future<Map> getMovie() async{
    MovieService instance = MovieService();

    await instance.getMovie(movieID);
    Map movieDetail = {'title': instance.title, 'genre': instance.genre, 'overview': instance.overview, 'producer': instance.production_companies};
    return movieDetail;
  }

  Widget carousel(){
    return Container(
      child: FutureBuilder <Map>(
        future: getMovie(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            Map data = snapshot.data;
            return Wrap(
              children: [
                Text(data['title']),
                Text(data['genre']),
                Text(data['overview']),
                // Text(data['producer']),
              ],
            );
          }
          return CircularProgressIndicator();
        },

      )
    );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('My Movie App'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: ListView(
            children: [
              carousel()
            ],
          ),
          // child: FutureBuilder <List<MovieService>>(
          //   future: futureData,
          //   builder: (context, snapshot){
          //     if(snapshot.hasData){
          //       List<MovieService> data = snapshot.data;
          //       return ListView.builder(
          //           itemCount: data.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             return Card(
          //               child: Row(
          //                 children: <Widget>[
          //                   Text('sdfsdf')
          //                 ],
          //               ),
          //             );
          //         },
          //       );
          //     }
          //     return CircularProgressIndicator();
          //   },
          // ),
        )
    );
  }
}