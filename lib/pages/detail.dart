import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String title;
  var data;

  @override
  void initState() {
    super.initState();
  }

  Future<Map> getDetail(movieID) async{
    MovieService instance = MovieService();

    var data = await instance.getMovie(movieID);
    if(data['altTitle'] != 'Given'){
      title = data['altTitle'];
    }else{
      title = data['title'];
    }
    return data;
  }

  Future getCredit(movieID) async{
    MovieService instance = MovieService();

    var data = await instance.getCredit(movieID);

    return data;
  }

  Future getSimilar(movieID) async{
    MovieService instance = MovieService();

    var data = await instance.getSimilar(movieID);
    print(data);

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
                          'https://image.tmdb.org/t/p/w200${data['back']}'
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: <Widget>[
                          for(var genre in data['genre'])
                            Chip(
                              label: Text(genre['name'], style: TextStyle(color: Colors.white),),
                              backgroundColor: Colors.deepPurple,
                            )
                        ],
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
            textAlign: TextAlign.justify,
          ),
        ],
      )
    );
  }

  Widget movieCredit(movieID){
    return Container(
      child: FutureBuilder(
        future: getCredit(movieID),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Credit",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          height: 200,
                          width: 150,
                          child: Card(
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(15.0)
                            // ),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        Colors.blue,
                                        Colors.lightBlueAccent,
                                        Colors.white
                                      ]
                                  )
                              ),
                              child: Column(
                                children: [
                                  if(snapshot.data[index]['profile_path'] != null)
                                    Image.network('https://image.tmdb.org/t/p/w200${snapshot.data[index]['profile_path']}',
                                      width: 100, height: 100)
                                  else
                                    Image.asset('assets/blank.png', width: 50, height: 100,),
                                  Text("${snapshot.data[index]['name']}\n \tas\n${snapshot.data[index]['character']}")
                                ],
                              ),
                            ),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            );
          }
          else if(snapshot.hasError){
            return Text('Error');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget similarMovie(movieID){
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: FutureBuilder (
          future: getSimilar(movieID),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var data = snapshot.data;
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Text(
                      "Similar Movie",
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.black
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
                ),
              );
            }
            return CircularProgressIndicator();
          },
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.deepPurple,
                    Colors.blue
                  ]
              )
          ),
        ),
      ),
      body: FutureBuilder(
        future: getDetail(movieID),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w200/${snapshot.data['poster']}',
                  ),
                  fit: BoxFit.cover
                )
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 32.0, bottom: 100.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListView(
                      children: [
                        titleSection(snapshot.data),
                        textSection(snapshot.data),
                        movieCredit(movieID),
                        similarMovie(movieID)
                      ],
                    ),
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
