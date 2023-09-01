
import '../const/export.dart';
import 'package:dio/dio.dart';

class SearchService {
  Future<List<dynamic>> fetchSearchResults(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=${AppStrings.apiKey}&query=$query');

    final dio = Dio();
    final response = await dio.get(url.toString());
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      return jsonResponse[AppStrings.results];
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
