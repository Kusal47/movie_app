import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FontStyle/text_style.dart';
// import 'package:video_player/video_player.dart';
// // import 'package:chewie/chewie.dart';

class DetailPage extends StatefulWidget {
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
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
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
                        widget.movieImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 110,
                    left: 145,
                    child: InkWell(
                      onTap: () async {
                        if (widget.trailers != null &&
                            widget.trailers!.isNotEmpty) {
                          await launch(widget.trailers![0]);
                          print('Trailer is' + widget.trailers!.toString());
                        } else {
                          print('Trailer is currently unavailable');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Trailer is currently unavailable',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'serif'),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.all(30),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.white,
                            ),
                          );
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
                    padding: const EdgeInsets.only(left: 8.0, top: 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 30,
                          color: Colors.white,
                        ),
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
                      widget.posterImage != null
                          ? widget.posterImage!
                          : 'https://via.placeholder.com/82x120?text=No+Thumbnail',
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
                            TextFont(
                                text: 'Rating: ${widget.movieRating}',
                                size: 16),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFont(
                          text: widget.movienName != null
                              ? widget.movienName!
                              : 'Loading...',
                          size: 26,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFont(
                          text: 'Release Date: ${widget.movieReleaseDate}',
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
                    text: widget.movieOverview!,
                    size: 16,
                  ),
                ),
              ],
            ),
            // FOR CAST DETAILS
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: widget.cast!.length,
                    itemBuilder: ((context, index) {
                      return widget.cast![index]['profile_path'] != null ||
                              widget.cast![index]['name'] != null ||
                              widget.cast![index]['character'] != null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 15, top: 10),
                                    height: 90,
                                    width: 90,
                                    child: Image.network(
                                      widget.cast![index]['profile_path'] !=
                                              null
                                          ? 'https://image.tmdb.org/t/p/w500/' +
                                              widget.cast![index]
                                                  ['profile_path']
                                          : 'https://via.placeholder.com/82x120?text=No+Thumbnail',
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFont(
                                        text:
                                            widget.cast![index]['name'] != null
                                                ? widget.cast![index]['name']
                                                : 'Loading...',
                                        size: 14,
                                      ),
                                      TextFont(
                                        text: widget.cast![index]
                                                    ['character'] !=
                                                null
                                            ? widget.cast![index]['character']
                                            : 'Loading...',
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Center(
                                child: TextFont(
                                  text: 'Cast Unavailable',
                                  size: 14,
                                ),
                              ),
                            );
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
