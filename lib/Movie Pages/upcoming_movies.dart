
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../ApiServices/services.dart';
import '../FontStyle/text_style.dart';
import '../const/export.dart';
import '../details.dart';

class UpcomingMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  const UpcomingMovies(
      {super.key, required this.upcoming, });

  //receive the list of movies from the main.dart
  final List upcoming;
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFont(
            text:AppStrings.upcoming,
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
                      final trailer = await ApiService.fetchTrailer(upcoming[index][AppStrings.id]);
                      final cast = await ApiService.getMovieCast(upcoming[index][AppStrings.id]);

                    
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      movieName: upcoming[index][AppStrings.title],
                                      posterImage:
                                          NetworkPath.networkImagePath +
                                              upcoming[index][AppStrings.poster_path],
                                      movieImage:
                                         NetworkPath.networkImagePath +
                                              upcoming[index][AppStrings.backdrop_path],
                                      movieRating: upcoming[index]
                                              [AppStrings.vote_average]
                                          .toString(),
                                      movieReleaseDate: upcoming[index]
                                          [AppStrings.release_date],
                                      movieOverview: upcoming[index]
                                          [AppStrings.overview],
                                      trailers:
                                          trailer != null ? [trailer] : [],
                                      cast: cast ,
                                    )));
                      
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
                                    upcoming[index][AppStrings.poster_path] != null
                                        ? NetworkPath.networkImagePath  +
                                            upcoming[index][AppStrings.poster_path]
                                        : NetworkPath.thumbnail,
                                  )),
                                ),
                              ),
                            ),
                            TextFont(
                              text: upcoming[index][AppStrings.title] ?? upcoming[index][AppStrings.name],
                              size: 16,
                              overflow: TextOverflow.ellipsis,
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
