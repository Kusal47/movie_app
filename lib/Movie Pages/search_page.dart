// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movieapp/FontStyle/text_style.dart';
import '../ApiServices/Searching.dart';
import '../ApiServices/services.dart';
import '../const/export.dart';
import '../details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchService _searchService;
  List<dynamic> _searchResults = [];
  @override
  void initState() {
    super.initState();
    _searchService = SearchService();
  }

  void _updateSearchResults(String query) {
    _searchService.fetchSearchResults(query).then((results) {
      setState(() {
        _searchResults = results;
      });
    }).catchError((error) {
      setState(() {
        _searchResults = [];
      });
    });
  }

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 0.8,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              height: height / 10,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: AppStrings.search,
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();

                      _searchResults = [];
                    },
                  ),
                ),
                onChanged: (value) {
                  _updateSearchResults(value);
                },
              ),
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: height / 1.15,
                child: _searchResults.isEmpty && controller.text.isNotEmpty
                    ? const Center(
                        child:
                            TextFont(text: AppStrings.searchNotFound, size: 14))
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = _searchResults[index];

                          return InkWell(
                            onTap: () async {
                              final trailer = await ApiService.fetchTrailer(
                                  _searchResults[index][AppStrings.id]);
                              final cast = await ApiService.getMovieCast(
                                  _searchResults[index][AppStrings.id]);
                              if (movie[AppStrings.poster_path] != null &&
                                  movie[AppStrings.backdrop_path] != null &&
                                  // movie['original_name'] != null &&
                                  // movie['release_date'] != null &&
                                  // movie['vote_average'] != null &&
                                  movie[AppStrings.overview] != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              movieName:
                                                  movie[AppStrings.title],
                                              posterImage: NetworkPath
                                                      .networkImagePath +
                                                  movie[AppStrings.poster_path],
                                              movieImage: NetworkPath
                                                      .networkImagePath +
                                                  movie[
                                                      AppStrings.backdrop_path],
                                              movieRating:
                                                  movie[AppStrings.vote_average]
                                                      .toString(),
                                              movieReleaseDate: movie[
                                                  AppStrings.release_date],
                                              movieOverview:
                                                  movie[AppStrings.overview],
                                              trailers: trailer != null
                                                  ? [trailer]
                                                  : [],
                                              cast: cast,
                                            )));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: TextFont(
                                        text: AppStrings.nodata,
                                        size: 14,
                                      ),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    backgroundColor: Colors.white,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 10,
                                    duration: const Duration(seconds: 10),
                                    action: SnackBarAction(
                                      label: AppStrings.ok,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      movie[AppStrings.poster_path] != null
                                          ? NetworkPath.networkImagePath +
                                              movie[AppStrings.poster_path]
                                          : NetworkPath.placeholderThumbnail,
                                      width: 100,
                                      height: 120,
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFont(
                                              text: movie[AppStrings.title] ??
                                                  movie[
                                                      AppStrings.original_name],
                                              size: 20,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            TextFont(
                                                text: movie[AppStrings
                                                        .release_date] ??
                                                    AppStrings.Processing,
                                                size: 16),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                      255, 206, 186, 5),
                                                  size: 14,
                                                ),
                                                TextFont(
                                                    text: movie[AppStrings
                                                            .vote_average]
                                                        .toString(),
                                                    size: 14),
                                              ],
                                            ),
                                            TextFont(
                                              text: movie[AppStrings.overview],
                                              overflow: TextOverflow.ellipsis,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
