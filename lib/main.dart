import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'movieDetails.dart';
import 'package:http/http.dart' as http;

import 'movie.dart';
import 'tv.dart';

void main() => runApp(MyApp());

const topRatedMoviesUrl =
    "https://api.themoviedb.org/3/movie/top_rated?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
const upcomingMoviesUrl =
    "https://api.themoviedb.org/3/movie/upcoming?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
const topRatedTVShowsUrl = "https://api.themoviedb.org/3/tv/popular?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
const nowPlayingMoviesUrl = "https://api.themoviedb.org/3/trending/all/day?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
//const searchMovies =        'https://api.themoviedb.org/3/search/multi?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&language=en-US&query=$query&page=$pageNumber');
const airingTodayUrl = "https://api.themoviedb.org/3/tv/airing_today?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movies")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            heading("Top Rated Movies"),
            getMovieBuilder(topRatedMoviesUrl),
            heading("Upcoming Movies"),
            getMovieBuilder(upcomingMoviesUrl),
            heading("Top Rated Tv Shows"),
            getTvBuilder(topRatedTVShowsUrl),
            heading("Trending"),
           getMovieBuilder(nowPlayingMoviesUrl),
           heading("Airing Today"),
           getTvBuilder(airingTodayUrl),
          ],
        ),
      ),
    );
  }

  Padding heading(String heading) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(heading),
          );
  }
}

Widget getMovieBuilder(String url) {
  return FutureBuilder(
      future: getMovies(url),
      builder: (context, snapshot) {
        List<Movie> movies = snapshot.data;
        return Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: movies.length,
            itemBuilder: (context, i) {
              print(movies[i]);
              return Container(
//                          padding: const EdgeInsets.only(right: 17.0),
                  child: MovieWidget(movies[i]));
            },
          ),
        );
      });
}

Future<List<Movie>> getMovies(String typeUrl) async {
  List<Movie> list = [];

  var url = typeUrl;
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    var r = json.decode(response.body);
    print('result $r');
    r = r['results'];
    print('result $r');
    for (var movie in r) {
      list.add(Movie.fromJson(movie));
    }
    print(list.length);

    return list;
  } else {
    return Future.error("Failed to establish connection");
  }
}

class MovieWidget extends StatelessWidget {
  final Movie movie;
  final _imageURL = 'https://image.tmdb.org/t/p/w500';

  MovieWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(movie: movie,)));
      },
          child: Hero(
            tag: movie.title,
            child: Container(
        alignment: Alignment.center,
        child: Container(
            margin: EdgeInsets.only(bottom: 10.0, left: 10.0),
            height: 180.0,
            width: 130.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 5.0,
                  offset: Offset(2.0, 3.0),
                )
              ],
              image: DecorationImage(
                image: NetworkImage(_imageURL + movie.posterPath),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),


        ),
      ),
          ),
    );
  }
}




Widget getTvBuilder(String url) {
  return FutureBuilder(
      future: getTvSeries(url),
      builder: (context, snapshot) {
        List<Tv> movies = snapshot.data;
        return Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: movies.length,
            itemBuilder: (context, i) {
              print(movies[i]);
              return Container(
//                          padding: const EdgeInsets.only(right: 17.0),
                  child: TvWidget(movies[i]));
            },
          ),
        );
      });
}


Future<List<Tv>> getTvSeries(String typeUrl) async {
  List<Tv> list = [];

  var url = typeUrl;
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    var r = json.decode(response.body);
    print('result $r');
    r = r['results'];
    print('result $r');
    for (var tv in r) {
      list.add(Tv.fromJson(tv));
    }
    print(list.length);

    return list;
  } else {
    return Future.error("Failed to establish connection");
  }
}

class TvWidget extends StatelessWidget {
  final Tv tv;
  final _imageURL = 'https://image.tmdb.org/t/p/w500';

TvWidget(this.tv);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(tv: tv,)));
      },
          child: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.0, left: 10.0),
          height: 180.0,
          width: 130.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 5.0,
                offset: Offset(2.0, 3.0),
              )
            ],
            image: DecorationImage(
              image: NetworkImage(_imageURL + tv.posterPath),
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),

          
        ),
      ),
    );
  }
}

