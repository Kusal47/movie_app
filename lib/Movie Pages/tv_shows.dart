// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movieapp/const/export.dart';
import '../ApiServices/services.dart';
import '../FontStyle/text_style.dart';
import '../details.dart';

class TvShows extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const TvShows({
    super.key,
    required this.tvshows,
  });

  //receive the list of tvshows from the main.dart
  final List tvshows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFont(
            text: AppStrings.tvshows,
            size: 26,
          ),
          SizedBox(
            height: 278,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              itemBuilder: ((context, index) {
                return InkWell(
                    onTap: () async {
                      final trailer = await ApiService.fetchTrailer( tvshows[index]['id']);
                      final cast = await ApiService.getTvCast( tvshows[index]['id']);

                      if (tvshows[index][AppStrings.original_name] != null &&
                          tvshows[index][AppStrings.backdrop_path] != null &&
                          tvshows[index][AppStrings.vote_average] != null &&
                          tvshows[index][AppStrings.first_air_date] != null &&
                          tvshows[index][AppStrings.overview] != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    movieName:
                                        tvshows[index][AppStrings.original_name] ?? tvshows[index][AppStrings.name],
                                    posterImage:
                                        NetworkPath.networkImagePath  +
                                            tvshows[index][AppStrings.poster_path],
                                    movieImage:
                                        NetworkPath.networkImagePath  +
                                            tvshows[index][AppStrings.backdrop_path],
                                    movieRating: tvshows[index][AppStrings.vote_average]
                                        .toString(),
                                    movieReleaseDate: tvshows[index]
                                        [AppStrings.first_air_date],
                                    movieOverview: tvshows[index][AppStrings.overview],
                                    trailers: trailer != null ? [trailer] : [],
                                    cast: cast)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              AppStrings.tvShows_error,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'serif'),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(30),
                            duration: const Duration(seconds: 3),
                            backgroundColor: Colors.white,
                          ),
                        );
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.only(right: 5),
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
                                    tvshows[index][AppStrings.poster_path] != null
                                        ? NetworkPath.networkImagePath  +
                                            tvshows[index][AppStrings.poster_path]
                                        : NetworkPath.placeholderThumbnail,
                                  )),
                                ),
                              ),
                            ),
                            TextFont(
                              text: tvshows[index][AppStrings.original_name] ?? tvshows[index][AppStrings.name],
                              size: 16,
                              overflow: TextOverflow.ellipsis,
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
