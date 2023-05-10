import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../Authentication/auth.dart';
import '../FontStyle/text_style.dart';
import '../Login Register/login_page.dart';
import '../Movie Pages/search_page.dart';
import '../Movie Pages/top_rated_movies.dart';
import '../Movie Pages/trending_movies.dart';
import '../Movie Pages/tv_shows.dart';
import '../Movie Pages/upcoming_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // to store the list of movies from the api
  List trendingMovies = [];
  List popularMovies = [];
  List topRatedMovies = [];
  List upcomingMovies = [];
  List tvShows = [];

//  to fetch the movies from the api
  final String apiKey = '3b3e044406dcc9dfd98161380ff671d0';
  final String apiReadAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYjNlMDQ0NDA2ZGNjOWRmZDk4MTYxMzgwZmY2NzFkMCIsInN1YiI6IjY0NDY2YzU4YzhmM2M0MDQ3NTQ1MGZlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qZZN8H99oxomNUmi1oUgZwfNMybxtvJ1T0-Bd_Yfmhw';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future fetchMovies() async {
    //initiailizing  TMDB
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, apiReadAccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    //fetching the  movies from the api

    Map trendingMovieResult =
        await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedMovieResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map upcomingMovieResult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map tvShowResult = await tmdbWithCustomLogs.v3.tv.getPopular();
    // print(trendingMovieResult['results'][2]);
    //     print(trendingMovieResult['results'][5]);

    //updating the state of the app
    setState(() {
      //storing the results in the trendingMovies list and so on for other lists
      trendingMovies = trendingMovieResult['results'];
      topRatedMovies = topRatedMovieResult['results'];
      upcomingMovies = upcomingMovieResult['results'];
      tvShows = tvShowResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextFont(text: 'Cinemania'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                        apiKey: apiKey,
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ),
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("My Account"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Settings"),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) async {
              if (value == 0) {
                print("My Account menu is selected.");
              } else if (value == 1) {
                print("Settings menu is selected.");
              } else if (value == 2) {
                await AuthService().SignOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
            }),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
          children: [
            //passing the list of movies to the TrendingMovies.dart and so on.
            TrendingMovies(
              trending: trendingMovies,
              apiKey: apiKey,
            ),
            UpcomingMovies(
              upcoming: upcomingMovies,
              apiKey: apiKey,
            ),
            TopRatedMovies(
              toprated: topRatedMovies,
              apiKey: apiKey,
            ),
            TvShows(
              tvshows: tvShows,
              apiKey: apiKey,
            ),
          ],
        ),
      ),
    );
  }
}
