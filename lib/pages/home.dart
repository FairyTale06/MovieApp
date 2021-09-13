import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail.dart';
import 'package:movie_app/services/movie_service.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;

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
            return Column(
              children: [
                Text(
                    "Top Rated Movie",
                  style: TextStyle(
                    fontSize: 26
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 16,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () async{
                                Navigator.pushNamed(context, "/detail", arguments: {"movieID": data[index]["id"]});
                              },
                              child: ListTile(
                                leading: Image.network('https://image.tmdb.org/t/p/w200/${data[index]['poster_path']}', height: 100),
                                title: Text(
                                  data[index]['original_title'],
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                subtitle: Text(
                                  "Popularity: "+(data[index]['popularity']).toString(),
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ),
                        ),
                      );
                    }
                ),
              ],
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
      backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('My Movie App'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: ListView(
            children: [
              // carousel(),
              topRated()
            ],
          ),
        )
    );
  }
}