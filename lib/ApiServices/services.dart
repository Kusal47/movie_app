import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
    static Future<List<dynamic>> getMovieCast(String apiKey, int movieId) async {
    final url =
'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data['cast'];
    } else {
      throw Exception('Failed to load search results');
    }
  }
  static Future<List<dynamic>> getTvCast(String apiKey, int movieId) async {
    final url =
        'https://api.themoviedb.org/3/tv/$movieId/credits?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data['cast'];
    } else {
      return [data];
    }
  }

  static Future<String?> fetchTrailer(String apiKey, int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'].isNotEmpty) {
        return 'https://www.youtube.com/watch?v=${data['results'][0]['key']}';
      }
    }
    return null;
  }
}
