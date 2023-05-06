import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../FontStyle/text_style.dart';
import '../details.dart';

class TrendingMovies extends StatelessWidget {
  //adding the constructor to receive the list of movies
  TrendingMovies({super.key, required this.trending, required this.apiKey});

  //receive the list of movies from the main.dart
  final List trending;
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
                      final trailer = await fetchTrailer(trending[index]['id']);
                      final cast = await getMovieCast(trending[index]['id']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    movienName: trending[index]['title'],
                                    posterImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            trending[index]['poster_path'],
                                    movieImage:
                                        'https://image.tmdb.org/t/p/w500/' +
                                            trending[index]['backdrop_path'],
                                    movieRating: trending[index]['vote_average']
                                        .toString(),
                                    movieReleaseDate: trending[index]
                                        ['release_date'],
                                    movieOverview: trending[index]['overview'],
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
                                              trending[index]['poster_path']!=null?'https://image.tmdb.org/t/p/w500/' +
                                          trending[index]['poster_path']:'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg',)
                               
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: TextFont(
                                text: trending[index]['title'] != null
                                    ? trending[index]['title']
                                    : 'Processing...',
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
