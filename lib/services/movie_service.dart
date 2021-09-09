import 'package:dio/dio.dart';
import 'dart:convert';

class MovieService {

  String APIKEY = '2a40536ee239d94cf345668ce6266a60';
  String ACCESSTOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTQwNTM2ZWUyMzlkOTRjZjM0NTY2OGNlNjI2NmE2MCIsInN1YiI6IjYxMjliNWYxMGQ5ZjVhMDA0M2RjMjczMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lk8LO40cO7xz5wfQ5ghH2LjLd2q-_X9b0IsPvU1BJTc';

  String title;
  String genre;
  String overview;
  var production_companies;
  int movieID = 550;

  Future<void> getMovie() async {
    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.get('https://api.themoviedb.org/3/movie/$movieID?api_key=$APIKEY');
      print(response.data);
    }catch(e){
      print(e);
    }
  }

  Future<void> getMovieList() async {
    try{
      Response response;
      String path;
      Dio dio = new Dio();
      response = await dio.get(path);
    }catch(e){
      print(e);
    }
  }
}