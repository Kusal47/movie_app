import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FontStyle/text_style.dart';
// import 'package:http/http.dart' as http;

class DetailPage extends StatelessWidget {
  DetailPage({
    super.key,
    this.movienName,
    this.posterImage,
    this.movieImage,
    this.movieRating,
    this.movieReleaseDate,
    this.movieOverview,
    this.trailers,
    this.cast,
  });
  final String? movienName,
      posterImage,
      movieImage,
      movieRating,
      movieReleaseDate,
      movieOverview;
  final List<String>? trailers;
  final List? cast;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          // physics: BouncingScrollPhysics(
          //     decelerationRate: ScrollDecelerationRate.normal),
          children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        movieImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 110,
                    left: 145,
                    child: InkWell(
                      onTap: () async {
                        print('Trailer is' + trailers!.toString());
                        if (trailers != null && trailers!.isNotEmpty) {
                          await launch(trailers![0]);
                        }
                      },
                      child: Icon(
                        Icons.play_circle_outlined,
                        size: 80,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 60,
                  //   left: 126,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.red,
                  //       foregroundColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //     onPressed: () async {
                  //       print('Trailer is ${trailers}');
                  //       if (trailers != null && trailers!.isNotEmpty) {
                  //         await launch(trailers![0] );
                  //       }

                  //     },
                  //     child: TextFont(
                  //       text: 'Watch Trailer',
                  //       size: 16,
                  //     ),
                  //   ),
                  // ),

                  Positioned(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 220,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      posterImage!=null? posterImage!: 
                      'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg'
                      ,
                      fit: BoxFit.cover,
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            TextFont(text: 'Rating: $movieRating', size: 16),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFont(
                          text: movienName != null ? movienName! : 'Loading...',
                          size: 26,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFont(
                          text: 'Release Date: $movieReleaseDate',
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFont(
                    text: 'Overview',
                    size: 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFont(
                    text: movieOverview!,
                    size: 16,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFont(
                    text: 'Cast',
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: cast!.length,
                    itemBuilder: ((context, index) {
                      return cast![index]['profile_path']!=null? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 15, top: 10),
                              height: 90,
                              width: 90,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/' +
                                    cast![index]['profile_path'],
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFont(
                                  text: cast![index]['name'] != null
                                      ? cast![index]['name']
                                      : 'Loading...',
                                  size: 14,
                                ),
                                TextFont(
                                  text: cast![index]['character']!= null
                                      ? cast![index]['character']
                                      : 'Loading...',
                                  size: 12,
                                ),
                              ],
                            ),
                          )
                        ],
                      ):Container();
                    }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
