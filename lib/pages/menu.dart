import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/TopRated.dart';
import 'package:movie_app/components/Upcoming.dart';
import 'package:movie_app/components/Popular.dart';
import 'package:movie_app/components/Homepage.dart';
import 'package:movie_app/components/Search.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  int _currentTabIndex = 0;


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

  TopRated topRated = TopRated();
  Upcoming upcoming = Upcoming();
  Popular popular = Popular();
  Search search = Search();
  Homepage homepage = Homepage();

  @override
  Widget build(BuildContext context) {

    final _kTabPages = <Widget>[
      Center(child: topRated),
      Center(child: popular),
      Center(child: homepage),
      Center(child: upcoming),
      Center(child: search),
    ];

    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Top Rated'),
      const BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'Popular'),
      const BottomNavigationBarItem(icon: Icon(Icons.av_timer), label: 'HOME'),
      const BottomNavigationBarItem(icon: Icon(Icons.av_timer), label: 'Upcoming'),
      const BottomNavigationBarItem(icon: Icon(Icons.av_timer), label: 'Search'),
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