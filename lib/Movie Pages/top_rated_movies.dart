// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../ApiServices/services.dart';
import '../FontStyle/text_style.dart';
import '../const/export.dart';
import '../details.dart';

class TopRatedMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const TopRatedMovies({
    super.key,
    required this.toprated,
    
  });

  //receive the list of movies from the main.dart
  final List toprated;
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFont(
            text: AppStrings.topRated,
            size: 26,
          ),
          Container(
            height: 276,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              itemBuilder: ((context, index) {
                return InkWell(
                    onTap: () async {
                      final trailer = await ApiService.fetchTrailer(toprated[index][AppStrings.id]);
                      final cast = await ApiService.getMovieCast(toprated[index][AppStrings.id]);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  movieName: toprated[index][AppStrings.title],
                                  posterImage:
                                     NetworkPath.networkImagePath +
                                          toprated[index][AppStrings.poster_path],
                                  movieImage:
                                      NetworkPath.networkImagePath +
                                          toprated[index][AppStrings.backdrop_path],
                                  movieRating: toprated[index][AppStrings.vote_average]
                                      .toString(),
                                  movieReleaseDate: toprated[index]
                                      [AppStrings.release_date],
                                  movieOverview: toprated[index][AppStrings.overview],
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
                                    toprated[index][AppStrings.poster_path] != null
                                        ? NetworkPath.networkImagePath  +
                                            toprated[index][AppStrings.poster_path]
                                        : NetworkPath.thumbnail,
                                  )),
                                ),
                              ),
                            ),
                            TextFont(
                              text: toprated[index][AppStrings.title] ?? toprated[index][AppStrings.name],
                              size: 16,
                              overflow: TextOverflow.ellipsis,
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
