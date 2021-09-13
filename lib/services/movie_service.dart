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

  Future<Map> getMovie(int movieID) async {
    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.get('$APIADD/3/movie/$movieID?api_key=$APIKEY');
      var title = response.data['title'];
      var genre = response.data["genres"][0]["name"];
      var overview = response.data['overview'];
      var production_companies = response.data['production_companies'];
      var poster = response.data['poster_path'];
      var popularity = response.data['popularity'];
      return {'title': title, 'genre': genre, 'overview': overview, 'production_companies': production_companies, 'poster': poster, 'popularity': popularity};
    }catch(e){
      print(e);
    }
  }

  Future getTopRated() async {
    try{
      Response response;
      String page = "1";
      // https://api.themoviedb.org/3/movie/top_rated?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US&page=1
      String path = 'https://api.themoviedb.org/3/movie/top_rated?api_key=2a40536ee239d94cf345668ce6266a60&language=en-US&page=1';
      Dio dio = new Dio();
      response = await dio.get(path);
      print(response);
      var result = response.data["results"];

      return result.toList();
    }catch(e){
      print(e);
    }
  }
}