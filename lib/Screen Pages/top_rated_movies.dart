import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../FontStyle/text_style.dart';
import '../details.dart';

class TopRatedMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const TopRatedMovies({super.key, required this.toprated,});

  //receive the list of movies from the main.dart
  final List toprated;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFont(
            text: 'Top Rated Movies',
            size: 26,
          ),
          Container(
            height: 276,
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () async {
                    final trailer = await fetchTrailer(toprated[index]['id']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  movienName: toprated[index]['title'],
                                  posterImage:
                                      'https://image.tmdb.org/t/p/w500/' +
                                          toprated[index]['poster_path'],
                                  movieImage:
                                      'https://image.tmdb.org/t/p/w500/' +
                                          toprated[index]['backdrop_path'],
                                  movieRating: toprated[index]['vote_average']
                                      .toString(),
                                  movieReleaseDate: toprated[index]
                                      ['release_date'],
                                  movieOverview: toprated[index]['overview'],
                                  trailers: trailer != null ? [trailer] : []
                                )));
                  },
                  child: Container(
                      width: 140,
                      child: Column(
                        children: [
                         Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/' +
                                          toprated[index]['poster_path']),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: TextFont(
                              text: toprated[index]['title'] != null
                                  ? toprated[index]['title']
                                  : 'Processing...',
                              size: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ))
                );
              }),
              itemCount: toprated.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
