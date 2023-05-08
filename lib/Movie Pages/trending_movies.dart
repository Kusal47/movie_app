import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../FontStyle/text_style.dart';
import '../details.dart';
import '../ApiServices/services.dart';


class TrendingMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  TrendingMovies({super.key, required this.trending, required this.apiKey});

  //receive the list of movies from the main.dart
  final List trending;
  final String apiKey;
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFont(
            text: 'Trending Movies',
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
                      final trailer = await ApiService.fetchTrailer(apiKey,trending[index]['id']);
                      final cast = await ApiService.getMovieCast(apiKey,trending[index]['id']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  movienName: trending[index]['title'] != null
                                      ? trending[index]['title']
                                      : trending[index]['name'],
                                  posterImage:
                                      'https://image.tmdb.org/t/p/w500/' +
                                          trending[index]['poster_path'],
                                  movieImage:
                                      'https://image.tmdb.org/t/p/w500/' +
                                          trending[index]['backdrop_path'],
                                  movieRating: trending[index]['vote_average']
                                      .toString(),
                                  movieReleaseDate:
                                      trending[index]['release_date'] != null
                                          ? trending[index]['release_date']
                                          : trending[index]['first_air_date'],
                                  movieOverview: trending[index]['overview'],
                                  trailers: trailer != null ? [trailer] : [],
                                  cast: cast)));
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
                                    trending[index]['poster_path'] != null
                                        ? 'https://image.tmdb.org/t/p/w500/' +
                                            trending[index]['poster_path']
                                        : 'https://via.placeholder.com/82x120?text=No+Thumbnail',
                                  )),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFont(
                                text: trending[index]['title'] != null
                                    ? trending[index]['title']
                                    : trending[index]['name'],
                                size: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )));
              }),
              itemCount: trending.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
