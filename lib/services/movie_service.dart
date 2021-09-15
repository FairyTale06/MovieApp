import 'package:dio/dio.dart';
import 'dart:convert';

class MovieService {

  String APIKEY = '2a40536ee239d94cf345668ce6266a60';
  String ACCESSTOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTQwNTM2ZWUyMzlkOTRjZjM0NTY2OGNlNjI2NmE2MCIsInN1YiI6IjYxMjliNWYxMGQ5ZjVhMDA0M2RjMjczMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lk8LO40cO7xz5wfQ5ghH2LjLd2q-_X9b0IsPvU1BJTc';
  String APIADD = 'https://api.themoviedb.org';

  Future getMovie(int movieID) async {
    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.get('$APIADD/3/movie/$movieID?api_key=$APIKEY');
      print(response.data['title']);
      var result = {
        'title' : response.data['original_title'],
        'altTitle' : response.data['title'],
        'genre' : response.data["genres"],
        'overview' : response.data['overview'],
        'production_companies' : response.data['production_companies'],
        'poster' : response.data['poster_path'],
        'popularity' : response.data['popularity'],
        'back' : response.data['backdrop_path'],
      };
      return result;
    }catch(e){
      print(e);
    }
  }

  Future getCredit(movieID) async {
    // https://api.themoviedb.org/3/movie/550/credits?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US
  }

  Future getSimilar(movieID) async {
    // https://api.themoviedb.org/3/movie/{movie_id}/similar?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US&page=1

  }

  Future getTopRated() async {
    try{
      Response response;
      String page = "1";
      // https://api.themoviedb.org/3/movie/top_rated?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US&page=1
      String path = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$APIKEY&language=en-US&page=1';
      Dio dio = new Dio();
      response = await dio.get(path);
      var result = response.data["results"];

      return result.toList();
    }catch(e){
      print(e);
    }
  }

  Future getPopular() async {
    // https://api.themoviedb.org/3/movie/popular?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US&page=1
    try{
      Response response;
      String page = "1";
      String path = 'https://api.themoviedb.org/3/movie/popular?api_key=$APIKEY&language=en-US&page=$page';
      Dio dio = new Dio();
      response = await dio.get(path);
      var result = response.data["results"];

      return result.toList();
    }catch(e){
      print(e);
    }
  }

  Future getUpcoming() async{
    // https://api.themoviedb.org/3/movie/upcoming?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US&page=1
    try{
      Response response;
      String page = "1";
      String path = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$APIKEY&language=en-US&page=$page';
      Dio dio = new Dio();
      response = await dio.get(path);
      var result = response.data["results"];

      return result.toList();
    }catch(e){
      print(e);
    }
  }

}