import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/FontStyle/text_style.dart';

import '../details.dart';

class SearchPage extends StatefulWidget {
  SearchPage({required this.apiKey});
  final String apiKey;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _searchResults = [];

  Future<Map<String, dynamic>> _fetchSearchResults(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=${widget.apiKey}&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load search results');
    }
  }

  void _updateSearchResults(String query) {
    _fetchSearchResults(query).then((results) {
      setState(() {
        _searchResults = results['results'];
      });
    }).catchError((error) {
      setState(() {
        _searchResults = [];
      });
    });
  }

  Future<List<dynamic>> getMovieCast(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=${widget.apiKey}';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data['cast'];
    } else {
      throw Exception('Failed to load search results');
    }
  }

  Future<String?> fetchTrailer(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=3b3e044406dcc9dfd98161380ff671d0&language=en-US'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'].isNotEmpty) {
        return 'https://www.youtube.com/watch?v=${data['results'][0]['key']}';
      }
    }
    return null;
  }

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 0.8,
              padding: EdgeInsets.only(left: 5, right: 5),
              height: height / 10,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Search movies...',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  suffixIcon: IconButton(
                    focusColor: Colors.green,
                    mouseCursor: MouseCursor.defer,
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();

                      _searchResults = [];
                    },
                  ),
                ),
                onChanged: (value) {
                  _updateSearchResults(value);
                },
              ),
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: height / 1.15,
                child: _searchResults.isEmpty && controller.text.isNotEmpty
                    ? Center(
                        child: TextFont(
                            text: ' Searched result not found', size: 14))
                    : ListView.builder(
                        physics: BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = _searchResults[index];

                          return InkWell(
                            onTap: () async {
                              final trailer = await fetchTrailer(
                                  _searchResults[index]['id']);
                              final cast = await getMovieCast(
                                  _searchResults[index]['id']);
                              if (movie['poster_path'] != null ||
                                  movie['backdrop_path'] != null ||
                                  movie['original_name'] != null ||
                                  movie['release_date'] != null ||
                                  movie['vote_average'] != null ||
                                  movie['overview'] != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              movienName: movie['title'],
                                              posterImage:
                                                  'https://image.tmdb.org/t/p/w500/' +
                                                      movie['poster_path'],
                                              movieImage:
                                                  'https://image.tmdb.org/t/p/w500/' +
                                                      movie['backdrop_path'],
                                              movieRating: movie['vote_average']
                                                  .toString(),
                                              movieReleaseDate:
                                                  movie['release_date'],
                                              movieOverview: movie['overview'],
                                              trailers: trailer != null
                                                  ? [trailer]
                                                  : [],
                                              cast:cast,
                                            )));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: TextFont(
                                        text: 'No data found',
                                        size: 14,
                                      ),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    backgroundColor: Colors.white,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 10,
                                    duration: Duration(seconds: 10),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      movie['poster_path'] != null
                                          ? 'https://image.tmdb.org/t/p/w500/' +
                                              movie['poster_path']
                                          : 'https://via.placeholder.com/82x120?text=No+Thumbnail',
                                      width: 100,
                                      height: 120,
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFont(
                                              text: movie['title'] != null
                                                  ? movie['title']
                                                  : movie['original_name'],
                                              size: 20,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            TextFont(
                                                text: movie['release_date'] !=
                                                        null
                                                    ? movie['release_date']
                                                    : 'Processing...',
                                                size: 16),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                      255, 206, 186, 5),
                                                  size: 14,
                                                ),
                                                TextFont(
                                                    text: movie['vote_average']
                                                                .toString() !=
                                                            null
                                                        ? movie['vote_average']
                                                            .toString()
                                                        : 'Processing...',
                                                    size: 14),
                                              ],
                                            ),
                                            TextFont(
                                              text: movie['overview'],
                                              overflow: TextOverflow.ellipsis,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
