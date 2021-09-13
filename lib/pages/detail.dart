import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String title;
  String genre;
  String overview;

  @override
  void initState() {
    super.initState();
  }

  void getDetail() async{
    MovieService instance = MovieService();
    int i =0;

    await instance.getMovie(i);
    title = instance.title;
    genre = instance.genre;
    overview = instance.overview;
  }

  Widget titleSection(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "title",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      'Kandesstag',
                    )
                  ],
                )
            ),
            Icon(
              Icons.star,
              color: Colors.red[500],
            )
          ],
        ),
      ),
    );
  }

  Widget textSection = Padding(
    padding: EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sdsfsdf"),
      ),
      body: Card(
        child: ListView(
          children: [
            titleSection(),
            textSection
          ],
        ),
      )
    );
  }
}
