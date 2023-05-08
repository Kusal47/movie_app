import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../ApiServices/services.dart';
import '../FontStyle/text_style.dart';
import '../details.dart';

class TopRatedMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const TopRatedMovies({
    super.key,
    required this.toprated,
    required this.apiKey,
  });

  //receive the list of movies from the main.dart
  final List toprated;
  final String apiKey;
 

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
                      final trailer = await ApiService.fetchTrailer(apiKey,toprated[index]['id']);
                      final cast = await ApiService.getMovieCast(apiKey,toprated[index]['id']);

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
                                    toprated[index]['poster_path'] != null
                                        ? 'https://image.tmdb.org/t/p/w500/' +
                                            toprated[index]['poster_path']
                                        : 'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg',
                                  )),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFont(
                                text: toprated[index]['title'] != null
                                    ? toprated[index]['title']
                                    : toprated[index]['name'],
                                size: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )));
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
