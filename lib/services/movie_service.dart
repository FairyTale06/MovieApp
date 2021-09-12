import 'package:dio/dio.dart';
import 'dart:convert';

class MovieService {

  String APIKEY = '2a40536ee239d94cf345668ce6266a60';
  String ACCESSTOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTQwNTM2ZWUyMzlkOTRjZjM0NTY2OGNlNjI2NmE2MCIsInN1YiI6IjYxMjliNWYxMGQ5ZjVhMDA0M2RjMjczMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lk8LO40cO7xz5wfQ5ghH2LjLd2q-_X9b0IsPvU1BJTc';
  String APIADD = 'https://api.themoviedb.org';

  String title = "title0123";
  String genre;
  String overview;
  String poster;
  double popularity;
  var production_companies;

  Future<String> getMovie(int movieID) async {
    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.get('$APIADD/3/movie/$movieID?api_key=$APIKEY');
      title = response.data['title'];
      genre = response.data["genres"][0]["name"];
      overview = response.data['overview'];
      production_companies = response.data['production_companies'];
      poster = response.data['poster_path'];
      popularity = response.data['popularity'];

    }catch(e){
      print(e);
    }
  }

  Future<void> getTopRated() async {
    try{
      Response response;
      String page = "1";
      // https://api.themoviedb.org/3/movie/top_rated?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US&page=1
      String path = "$APIADD/3/movie/top_rated?api_key=$APIKEY&language=en-US&page=$page";
      Dio dio = new Dio();
      response = await dio.get(path);
      print(response);
    }catch(e){
      print(e);
    }
  }
}