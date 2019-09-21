import 'package:flutter/material.dart';
import 'package:flutter_movies/movie.dart';
import 'package:flutter_movies/tv.dart';

class MovieDetails extends StatelessWidget {
  final _imageURL = 'https://image.tmdb.org/t/p/w500';
  final Movie movie;
  final Tv tv;

  MovieDetails({this.movie, this.tv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie == null ? tv.name : movie.title),
      ),
      body: Scaffold(
        body: Hero(
          tag: movie.title,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(

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
