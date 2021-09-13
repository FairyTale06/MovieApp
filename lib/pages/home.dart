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

    var result = await instance.getMovie(movieID);
    String posterPath = result['poster'];
    Map movieDetail = {'title': result['title'], 'genre': result['genre'], 'overview': result['overview'], 'producer': result['production_companies'], 'image': 'https://image.tmdb.org/t/p/w200/$posterPath'};

    return movieDetail;
  }

  Future<List> getTopRated() async {
    MovieService instance = MovieService();

    var result = await instance.getTopRated();
    // print(result);
    // print(result[0]);
    return result;
  }

  Widget topRated(){
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: FutureBuilder <List>(
        future: getTopRated(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List data = snapshot.data;
            return Container(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 16,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      child: ListTile(
                        title: Text(data[index]['original_title']),
                      ),
                    );
                  }
              ),
            );
          }
          return CircularProgressIndicator();
        },
      )
    );
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
                Text(data['title']),
                Text(data['genre']),
                Text(data['overview']),
                Text(data['title']),
                Text(data['genre']),
                Text(data['overview']),
                Text(data['title']),
                Text(data['genre']),
                Text(data['overview']),
                Text(data['title']),
                Text(data['genre']),
                Text(data['overview']),
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
              carousel(),
              topRated()
            ],
          ),
        )
    );
  }
}