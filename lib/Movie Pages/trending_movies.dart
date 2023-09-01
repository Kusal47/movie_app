// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../FontStyle/text_style.dart';
import '../const/export.dart';
import '../details.dart';
import '../ApiServices/services.dart';


class TrendingMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const TrendingMovies({super.key, required this.trending, });

  //receive the list of movies from the main.dart
  final List trending;
 
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFont(
            text: AppStrings.trending,
            size: 26,
          ),
          SizedBox(
            height: 276,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              itemBuilder: ((context, index) {
                return InkWell(
                    onTap: () async {
                      final trailer = await ApiService.fetchTrailer(trending[index][AppStrings.id]);
                      final cast = await ApiService.getMovieCast(trending[index][AppStrings.id]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  movieName: trending[index][AppStrings.title] ?? trending[index][AppStrings.name],
                                  posterImage:
                                      NetworkPath.networkImagePath  +
                                          trending[index][AppStrings.poster_path],
                                  movieImage:
                                      NetworkPath.networkImagePath  +
                                          trending[index][AppStrings.backdrop_path],
                                  movieRating: trending[index][AppStrings.vote_average]
                                      .toString(),
                                  movieReleaseDate:
                                      trending[index][AppStrings.release_date] ?? trending[index][AppStrings.first_air_date],
                                  movieOverview: trending[index][AppStrings.overview],
                                  trailers: trailer != null ? [trailer] : [],
                                  cast: cast)));
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
                                    trending[index][AppStrings.poster_path] != null
                                        ? NetworkPath.networkImagePath  +
                                            trending[index][AppStrings.poster_path]
                                        : NetworkPath.placeholderThumbnail,
                                  )),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFont(
                                text: trending[index][AppStrings.title] ?? trending[index][AppStrings.name],
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
