import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

bool searched = false;
String search;

Future getSearch(keyword) async {
  MovieService instance = MovieService();

  var result = await instance.getSearch(keyword);

  return result;
}

  Widget searchBar(){
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.blue,
          labelText: 'Search Something Here...'
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value){

        },
      )
    );
  }

  Widget searchedList(){
  print("searched");
    if (searched == true){
      print("searched true");
      return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: FutureBuilder (
            future: getSearch(search),
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
    else{
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Center(
          child: Text("^Search Something On The Bar Above^",
              style: TextStyle(
                color: Colors.white
              ),
          ),
        ),
      );
    }
  }

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    // getSearch();
    return ListView(
      children: [
        searchBar(),
      ],
    );
  }
}
