import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  int _currentTabIndex = 0;

  Future<List> getTopRated() async {
    MovieService instance = MovieService();

    var result = await instance.getTopRated();
    return result;
  }

  Future<List> getUpcoming() async {
    MovieService instance = MovieService();

    var result = await instance.getUpcoming();
    return result;
  }

  Future<List> getPopular() async {
    MovieService instance = MovieService();

    var result = await instance.getPopular();
    return result;
  }

  Widget popular(){
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: FutureBuilder <List>(
          future: getPopular(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              List data = snapshot.data;
              return Column(
                children: [
                  Text(
                    "Popular Movie",
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
                            color: Color(0xff5345cc),
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

  Widget upcoming(){
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: FutureBuilder <List>(
          future: getUpcoming(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              List data = snapshot.data;
              return Column(
                children: [
                  Text(
                    "Upcoming Movie",
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
                            color: Color(0xff5345cc),
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
                          color: Color(0xff5345cc),
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

//   Widget carousel(){
//     return Container(
//       child: FutureBuilder <Map>(
//         future: getPopular(),
//         builder: (context, snapshot){
//           if(snapshot.hasData){
//             Map data = snapshot.data;
//             return Wrap(
//               children: [
//                 Text(data['title']),
//                 Text(data['genre']),
//                 Text(data['overview']),
//                 Text(data['title']),
//                 // Text(data['producer']),
//               ],
//             );
//           }
//           return CircularProgressIndicator();
//         },
//       )
//     );
// }

  @override
  Widget build(BuildContext context) {

    final _kTabPages = <Widget>[
      Center(child: topRated()),
      Center(child: popular()),
      Center(child: upcoming()),
    ];

    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Top Rated'),
      const BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'Popular'),
      const BottomNavigationBarItem(icon: Icon(Icons.av_timer), label: 'Upcoming'),
    ];

    assert(_kTabPages.length == _kBottomNavBarItems.length);

    final bottomNavBar = BottomNavigationBar(
        items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
          setState(() {
            _currentTabIndex = index;
          });
      },
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('My Movie App'),
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
          // backgroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            color: Color(0xff042861),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _kTabPages[_currentTabIndex]
            ),
          )
        ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}