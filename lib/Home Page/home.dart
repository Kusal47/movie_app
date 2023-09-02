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
import '../const/export.dart';

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


  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future fetchMovies() async {
    //initiailizing  TMDB
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(AppStrings.apiKey, AppStrings.apiReadAccessToken),
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

    //updating the state of the app
    setState(() {
      //storing the results in the trendingMovies list and so on for other lists
      trendingMovies = trendingMovieResult[AppStrings.results];
      topRatedMovies = topRatedMovieResult[AppStrings.results];
      upcomingMovies = upcomingMovieResult[AppStrings.results];
      tvShows = tvShowResult[AppStrings.results];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TextFont(text: AppStrings.appName),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ),
            PopupMenuButton(itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(AppStrings.myAccount),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text(AppStrings.settings),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text(AppStrings.logout),
                ),
              ];
            }, onSelected: (value) async {
              if (value == 0) {
                // print("My Account menu is selected.");
              } else if (value == 1) {
                // print("Settings menu is selected.");
              } else if (value == 2) {
                await AuthService().SignOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
            }),
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
          children: [
            //passing the list of movies to the TrendingMovies.dart and so on.
            TrendingMovies(
              trending: trendingMovies,
            ),
            UpcomingMovies(
              upcoming: upcomingMovies,
            ),
            TopRatedMovies(
              toprated: topRatedMovies,
            ),
            TvShows(
              tvshows: tvShows,
            ),
          ],
        ),
      ),
    );
  }
}
