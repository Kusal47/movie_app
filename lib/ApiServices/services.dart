import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio();

  static Future<List<dynamic>> getMovieCast(String apiKey, int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    final response = await _dio.get(url);
    final data = response.data;
    
    if (response.statusCode == 200) {
      return data['cast'];
    } else {
      throw Exception('Failed to load search results');
    }
  }

  static Future<List<dynamic>> getTvCast(String apiKey, int movieId) async {
    final url =
        'https://api.themoviedb.org/3/tv/$movieId/credits?api_key=$apiKey';

    final response = await _dio.get(url);
    final data = response.data;
    
    if (response.statusCode == 200) {
      return data['cast'];
    } else {
      return [data];
    }
  }

  static Future<String?> fetchTrailer(String apiKey, int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US';

    final response = await _dio.get(url);
    final data = response.data;
    
    if (response.statusCode == 200) {
      if (data['results'].isNotEmpty) {
        return 'https://www.youtube.com/watch?v=${data['results'][0]['key']}';
      }
    }
    return null;
  }
}
