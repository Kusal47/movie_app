import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchService {
  final String apiKey;

  SearchService({required this.apiKey});

  Future<List<dynamic>> fetchSearchResults(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['results'];
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
