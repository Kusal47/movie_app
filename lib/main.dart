import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FontStyle/text_style.dart';
import 'Screen Pages/search_page.dart';
import 'Screen Pages/top_rated_movies.dart';
import 'Screen Pages/trending_movies.dart';
import 'Screen Pages/tv_shows.dart';
import 'Screen Pages/upcoming_movies.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.transparent,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 90,
                child: Image.asset('assets/Image/appIcon.png'),
              ),
              Flexible(
                child: DefaultTextStyle(
                    child: Text('Netflix'),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.black,
                  minHeight: 5,
                ),
              )
            ],
          ),
        ));
  }
}

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
          title: TextFont(text: 'Netflix'),
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
