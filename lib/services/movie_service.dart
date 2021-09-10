import 'package:dio/dio.dart';
import 'dart:convert';

class MovieService {

  String APIKEY = '2a40536ee239d94cf345668ce6266a60';
  String ACCESSTOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTQwNTM2ZWUyMzlkOTRjZjM0NTY2OGNlNjI2NmE2MCIsInN1YiI6IjYxMjliNWYxMGQ5ZjVhMDA0M2RjMjczMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lk8LO40cO7xz5wfQ5ghH2LjLd2q-_X9b0IsPvU1BJTc';

  String title = "title0123";
  String genre;
  String overview;
  var production_companies;

  // MovieService({this.title});

  Future<String> getMovie(int movieID) async {
    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.get('https://api.themoviedb.org/3/movie/$movieID?api_key=$APIKEY');
      title = response.data['title'];
      genre = response.data['genres']['name'];
      overview = response.data['overview'];
      production_companies = response.data['production_companies'];
      print("service"+title);
    }catch(e){
      print(e);
    }
  }

  // Future<void> getMovieList() async {
  //   try{
  //     Response response;
  //     String path;
  //     Dio dio = new Dio();
  //     response = await dio.get(path);
  //   }catch(e){
  //     print(e);
  //   }
  // }
}