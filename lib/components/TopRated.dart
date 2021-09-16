import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class TopRated extends StatefulWidget {

  String movieID;

  @override
  _TopRatedState createState() => _TopRatedState();
}

Future<List> getTopRated() async {
  MovieService instance = MovieService();

  var result = await instance.getTopRated();
  return result;
}

class _TopRatedState extends State<TopRated> {
  @override
  Widget build(BuildContext context) {
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
                        fontSize: 26,
                        color: Colors.white
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
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        Colors.deepPurple,
                                        Colors.deepPurpleAccent,
                                        Colors.blueAccent
                                      ]
                                  )
                              ),
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
}
