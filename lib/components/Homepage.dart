import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

String _url = "https://www.themoviedb.org/";

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

Widget description(){
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Hi There, this is an application built with Flutter and  powered by TMDB."),
              InkWell(
                child: Text(_url),
                onTap: (){
                  _launchURL();
                },
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Future getShowing() async {
  MovieService instance = MovieService();

  var result = await instance.getShowing();
  return result;
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          FutureBuilder(
              future: getShowing(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  print(snapshot.data);
                  var data = snapshot.data;
                  return CarouselSlider.builder(
                      itemCount: data.length,
                      options: CarouselOptions(
                        height: 400,
                        autoPlay: true,
                      ),
                      itemBuilder: (context, itemIndex, realIndex){
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/detail", arguments: {"movieID": data[itemIndex]["id"]});
                          },
                          child: Container(
                            width: 250,
                            height: 300,
                            child: Image.network('https://image.tmdb.org/t/p/w200/${data[itemIndex]['poster_path']}',fit: BoxFit.cover,),
                          ),
                        );
                      },
                  );
                }
                return CircularProgressIndicator();
              }
          ),
          description()
        ],
      ),
    );
  }
}
