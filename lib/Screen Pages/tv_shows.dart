import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../FontStyle/text_style.dart';
import '../details.dart';

class TvShows extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const TvShows({
    super.key,
    required this.tvshows, required this.apiKey,
  });

  //receive the list of movies from the main.dart
  final List tvshows;
  final String apiKey;
  Future<List<dynamic>> getMovieCast(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    return data['results'];
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFont(
            text: ' Popular Tvshows',
            size: 26,
          ),
          Container(
            height: 278,
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              itemBuilder: ((context, index) {
                return InkWell(
                    onTap: () async {
                      final trailer = await fetchTrailer(tvshows[index]['id']);
                                            final cast = await getMovieCast(tvshows[index]['id']);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    movienName: tvshows[index]['original_name'],
                                    posterImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            tvshows[index]['poster_path'],
                                    movieImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            tvshows[index]['backdrop_path'],
                                    movieRating: tvshows[index]['vote_average']
                                        .toString(),
                                    movieReleaseDate: tvshows[index]
                                        ['release_date'],
                                    movieOverview: tvshows[index]['overview'],
                                    trailers: trailer != null ? [trailer] : [],
                                                                        cast: cast != null ? cast : [],

                                  )));
                    },
                    child: Container(
                                              padding: EdgeInsets.only(right:5),

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
                                               tvshows[index]['poster_path']!=null?'https://image.tmdb.org/t/p/w500/' +
                                          tvshows[index]['poster_path']:'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg',)
                               
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFont(
                                text: tvshows[index]['original_name'] != null
                                    ? tvshows[index]['original_name']
                                    : 'Processing...',
                                size: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )));
              }),
              itemCount: tvshows.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
