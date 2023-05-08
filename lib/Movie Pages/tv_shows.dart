import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../ApiServices/services.dart';
import '../FontStyle/text_style.dart';
import '../details.dart';

class TvShows extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const TvShows({
    super.key,
    required this.tvshows,
    required this.apiKey,
  });

  //receive the list of tvshows from the main.dart
  final List tvshows;
  final String apiKey;


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
                   final trailer =
                        await ApiService.fetchTrailer(apiKey, tvshows[index]['id']);
                    final cast =
                        await ApiService.getTvCast(apiKey, tvshows[index]['id']);

                      if (tvshows[index]['original_name'] != null &&
                          tvshows[index]['backdrop_path'] != null &&
                          tvshows[index]['vote_average'] != null &&
                          tvshows[index]['first_air_date'] != null &&
                          tvshows[index]['overview'] != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    movienName:
                                        tvshows[index]['original_name'] != null
                                            ? tvshows[index]['original_name']
                                            : tvshows[index]['name'],
                                    posterImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            tvshows[index]['poster_path'],
                                    movieImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            tvshows[index]['backdrop_path'],
                                    movieRating: tvshows[index]['vote_average']
                                        .toString(),
                                    movieReleaseDate: tvshows[index]
                                        ['first_air_date'],
                                    movieOverview: tvshows[index]['overview'],
                                    trailers: trailer != null ? [trailer] : [],
                                    cast: cast)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Sorry, this Tvshow is unavailable',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'serif'),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(40),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.white,
                          ),
                        );
                      }
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
                                    tvshows[index]['poster_path'] != null
                                        ? 'https://image.tmdb.org/t/p/w500/' +
                                            tvshows[index]['poster_path']
                                        : 'https://via.placeholder.com/82x120?text=No+Thumbnail',
                                  )),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFont(
                                text: tvshows[index]['original_name'] != null
                                    ? tvshows[index]['original_name']
                                    : tvshows[index]['name'],
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
