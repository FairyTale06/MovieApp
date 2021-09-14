import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String title;
  var genre;
  String overview;
  var data;

  @override
  void initState() {
    super.initState();
  }

  Future<Map> getDetail(movieID) async{
    MovieService instance = MovieService();

    var data = await instance.getMovie(movieID);
    title = data['original_title'];
    genre = data['genre'];
    overview = data['overview'];
    return data;
  }

  Widget titleSection(data){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 5.0),
        child: Center(
          child: Row(
            children: [
              Expanded(
                  child: Column(
                    children: [
                      Image.network(
                          'https://image.tmdb.org/t/p/w200${data['background']}'
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          data["title"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                        ),
                      ),
                      Chip(
                        label: Text(data['genre'], style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.deepPurple,
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textSection(data){
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Text("Overview",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0
            ),
          ),
          Text(
            data['overview'],
            softWrap: true,
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    int movieID = data['movieID'];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Movie Info"),
      ),
      body: FutureBuilder(
        future: getDetail(movieID),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w200/${snapshot.data['poster']}'
                  ),
                  fit: BoxFit.cover
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 32.0, bottom: 100.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListView(
                    children: [
                      titleSection(snapshot.data),
                      textSection(snapshot.data)
                    ],
                  ),
                ),
              )
            );
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
}
