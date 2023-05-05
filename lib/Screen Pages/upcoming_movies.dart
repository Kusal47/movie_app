import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../FontStyle/text_style.dart';
import '../details.dart';

class UpcomingMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const UpcomingMovies(
      {super.key, required this.upcoming, required this.apiKey});

  //receive the list of movies from the main.dart
  final List upcoming;
  final String apiKey;
  Future<List<dynamic>> getMovieCast(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    return data['cast'];
  }

  Future<String?> fetchTrailer(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US'));
    final data = jsonDecode(response.body);
    return data['cast'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFont(
            text: 'Upcoming Movies',
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
                      final trailer = await fetchTrailer(upcoming[index]['id']);
                      final cast = await getMovieCast(upcoming[index]['id']);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    movienName: upcoming[index]['title'],
                                    posterImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            upcoming[index]['poster_path'],
                                    movieImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            upcoming[index]['backdrop_path'],
                                    movieRating: upcoming[index]['vote_average']
                                        .toString(),
                                    movieReleaseDate: upcoming[index]
                                        ['release_date'],
                                    movieOverview: upcoming[index]['overview'],
                                    trailers: trailer != null ? [trailer] : [],
                                    cast: cast != null ? cast : [],
                                  )));
                    },
                    child: Container(
                        padding: EdgeInsets.only(right: 5),
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
                                      upcoming[index]['poster_path'] != null
                                          ? 'https://image.tmdb.org/t/p/w500${upcoming[index]['poster_path']}'
                                          : 'https://via.placeholder.com/92x138.png?text=No+Poster+Available',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFont(
                                text: upcoming[index]['title'] != null
                                    ? upcoming[index]['title']
                                    : 'Processing...',
                                size: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )));
              }),
              itemCount: upcoming.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
