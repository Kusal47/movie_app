import 'package:flutter/material.dart';
import 'package:movieapp/FontStyle/text_style.dart';
import '../ApiServices/Searching.dart';
import '../ApiServices/services.dart';
import '../details.dart';

class SearchPage extends StatefulWidget {
  SearchPage({required this.apiKey});
  final String apiKey;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   late final SearchService _searchService; 
    List<dynamic> _searchResults = [];
    @override
  void initState() {
    super.initState();
    _searchService = SearchService(apiKey: widget.apiKey);
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
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              height: height / 10,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Search movies...',
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
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
                    ? Center(
                        child: TextFont(
                            text: ' Searched result not found', size: 14))
                    : ListView.builder(
                        physics: BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = _searchResults[index];

                          return InkWell(
                            onTap: () async {
                              final trailer = await ApiService.fetchTrailer(
                                  widget.apiKey, _searchResults[index]['id']);
                              final cast = await ApiService.getMovieCast(
                                  widget.apiKey, _searchResults[index]['id']);
                              if (movie['poster_path'] != null &&
                                  movie['backdrop_path'] != null &&
                                  // movie['original_name'] != null &&
                                  // movie['release_date'] != null &&
                                  // movie['vote_average'] != null &&
                                  movie['overview'] != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              movienName: movie['title'],
                                              posterImage:
                                                  'https://image.tmdb.org/t/p/w500/' +
                                                      movie['poster_path'],
                                              movieImage:
                                                  'https://image.tmdb.org/t/p/w500/' +
                                                      movie['backdrop_path'],
                                              movieRating: movie['vote_average']
                                                  .toString(),
                                              movieReleaseDate:
                                                  movie['release_date'],
                                              movieOverview: movie['overview'],
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
                                        text: 'No data found',
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
                                    duration: Duration(seconds: 10),
                                    action: SnackBarAction(
                                      label: 'OK',
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
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      movie['poster_path'] != null
                                          ? 'https://image.tmdb.org/t/p/w500/' +
                                              movie['poster_path']
                                          : 'https://via.placeholder.com/82x120?text=No+Thumbnail',
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
                                              text: movie['title'] != null
                                                  ? movie['title']
                                                  : movie['original_name'],
                                              size: 20,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            TextFont(
                                                text: movie['release_date'] !=
                                                        null
                                                    ? movie['release_date']
                                                    : 'Processing...',
                                                size: 16),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                      255, 206, 186, 5),
                                                  size: 14,
                                                ),
                                                TextFont(
                                                    text: movie['vote_average']
                                                                .toString(),
                                                    size: 14),
                                              ],
                                            ),
                                            TextFont(
                                              text: movie['overview'],
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
