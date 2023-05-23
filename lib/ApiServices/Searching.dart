import 'package:dio/dio.dart';

class SearchService {
  final String apiKey;

  SearchService({required this.apiKey});

  Future<List<dynamic>> fetchSearchResults(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query');

    final dio = Dio();
    final response = await dio.get(url.toString());

    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      return jsonResponse['results'];
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
