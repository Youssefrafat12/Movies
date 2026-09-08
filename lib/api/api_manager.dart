import 'package:dio/dio.dart';
import 'package:movies_app/api/api_constant.dart';
import 'package:movies_app/api/end_points.dart';
import 'package:movies_app/api/model/movie_details_response/movie_details_response.dart';
import 'package:movies_app/api/model/movie_suggestions_response/movie_suggestions_response.dart';
import 'model/movie_list/movies_list.dart';

class ApiManager {
  static final dio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl));

  //https://movies-api.accel.li/api/v2/movie_details.json?movie_id=15&with_images=true&with_cast=true

  static Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    var response = await dio.get(
      EndPoints.movieDetails,
      queryParameters: {
        'movie_id': movieId,
        'with_images': true,
        'with_cast': true,
      },
    );
    var responseData = await response.data;
    return MovieDetailsResponse.fromJson(responseData);
  }

  static Future<MovieSuggestionsResponse> getMovieSuggestions(
    int movieId,
  ) async {
    try {
      var response = await dio.get(
        EndPoints.movieSuggestions,
        queryParameters: {'movie_id': movieId},
      );
      var responseBody = await response.data;
      return MovieSuggestionsResponse.fromJson(responseBody);
    } catch (e) {
      rethrow;
    }
  }

  static Future<MoviesList> getMoviesByGenre(String genre) async {
    try {
      var response = await dio.get(
        EndPoints.movieList,
        queryParameters: {"genre": genre},
      );
      return MoviesList.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<MoviesList> searchMovies(String query) async {
    try {
      var response = await dio.get(
        EndPoints.movieList,
        queryParameters: {"query_term": query},
      );
      return MoviesList.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<MoviesList> getAllMovie() async {
    try {
      var response = await dio.get(EndPoints.movieList);
      return MoviesList.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
