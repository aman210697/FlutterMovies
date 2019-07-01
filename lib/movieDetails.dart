import 'package:flutter/material.dart';
import 'package:flutter_movies/movie.dart';
import 'package:flutter_movies/tv.dart';


class MovieDetails extends StatelessWidget {
final Movie movie;
final Tv tv;

MovieDetails({this.movie, this.tv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie==null?tv.name:movie.title),),

    );
  }
}