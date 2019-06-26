import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/movie.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

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
            FutureBuilder(
                future: getTopRatedMovies(),
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
                }),
            FutureBuilder(
                future: getTopRatedMovies(),
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
                }),
            FutureBuilder(
                future: getTopRatedMovies(),
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
                }),
          ],
        ),
      ),
    );
  }
}

Future<List<Movie>> getTopRatedMovies() async {
  List<Movie> list = [];

  var url =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    // Movie.fromJson(JsonDecoder().convert(response.body));
    //  String receivedJson = json.decode(response.body);
    var r = json.decode(response.body);
    print('result $r');

    r = r['results'];
    print('result $r');

    for (var movie in r) {
      list.add(Movie.fromJson(movie));
    }

    print(list.length);

    return list;

//    }

//    List<Movie> movie = r.map((Map model) => Movie.fromJson(model)).toList();

//    print('hello world$movie');
//    return r;
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
    return Container(
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
    );
  }
}
