import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Buttons/button.dart';
import 'package:movieapp/Movie%20Pages/buy_ticket.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'FontStyle/text_style.dart';
import 'const/export.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    this.movieName,
    this.posterImage,
    this.movieImage,
    this.movieRating,
    this.movieReleaseDate,
    this.movieOverview,
    this.trailers,
    this.cast,
  });
  final String? movieName,
      posterImage,
      movieImage,
      movieRating,
      movieReleaseDate,
      movieOverview;
  final List<String>? trailers;
  final List? cast;

  //updating the state of the app

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
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.movieImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Buttons(
                              btnname: AppStrings.trailer,
                              size: 20,
                              color: Colors.red,
                              isDetail: true,
                              onPressed: () async {
                                try {
                                  // Assuming widget.trailers[0] is a YouTube video URL
                                  final youtubeUrl = widget.trailers![0];

                                  Response response =
                                      await Dio().get(youtubeUrl);

                                  if (response.statusCode == 200) {
                                    // Parse the response to extract the video ID
                                    String videoId =
                                        YoutubePlayer.convertUrlToId(
                                            youtubeUrl)!;

                                    if (videoId.isNotEmpty) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SafeArea(
                                              child: Scaffold(
                                                body: Stack(children: [
                                                  Center(
                                                    child: YoutubePlayer(
                                                      aspectRatio: 4 / 3,
                                                      controller:
                                                          YoutubePlayerController(
                                                        initialVideoId: videoId,
                                                        flags:
                                                            const YoutubePlayerFlags(
                                                          enableCaption: true,
                                                          autoPlay: true,
                                                          mute: false,
                                                          forceHD: true,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            top: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_back_ios_new,
                                                            size: 25,
                                                            color: Colors.white,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: TextFont(
                                                              text: AppStrings
                                                                  .return_to_details,
                                                              size: 25,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  } else {
                                    print(response.statusMessage);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  }
                                } catch (error) {
                                  print('Error occurred: $error');
                                }
                              },
                            ),
                            Buttons(
                              btnname: AppStrings.tickets,
                              size: 20,
                              isDetail: true,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BuyTicketPage(
                                              movieName: widget.movieName,
                                              movieImage: widget.movieImage,
                                              movieReleaseDate:
                                                  widget.movieReleaseDate,
                                            )));
                              },
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 220,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                      widget.posterImage != null
                          ? widget.posterImage!
                          : NetworkPath.placeholderThumbnail,
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
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            TextFont(
                                text:
                                    '${AppStrings.rating} ${widget.movieRating}',
                                size: 16),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFont(
                          text: widget.movieName != null
                              ? widget.movieName!
                              : AppStrings.loading,
                          size: 26,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFont(
                          text:
                              '${AppStrings.release_on} ${widget.movieReleaseDate}',
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFont(
                    text: AppStrings.descOverview,
                    size: 30,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
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
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFont(
                    text: AppStrings.castNames,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: widget.cast?.length,
                    itemBuilder: ((context, index) {
                      return widget.cast![index][AppStrings.poster_path] !=
                                  null ||
                              widget.cast![index][AppStrings.name] != null ||
                              widget.cast![index][AppStrings.character] != null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    height: 90,
                                    width: 90,
                                    child: Image.network(
                                      widget.cast![index]
                                                  [AppStrings.profile_path] !=
                                              null
                                          ? NetworkPath.networkImagePath +
                                              widget.cast![index]
                                                  [AppStrings.profile_path]
                                          : NetworkPath.thumbnail,
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFont(
                                        text: widget.cast![index]
                                                [AppStrings.name] ??
                                            AppStrings.loading,
                                        size: 14,
                                      ),
                                      TextFont(
                                        text: widget.cast![index]
                                                [AppStrings.character] ??
                                            AppStrings.loading,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Center(
                                child: TextFont(
                                  text: AppStrings.cast_unavailable,
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
