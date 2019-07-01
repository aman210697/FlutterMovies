// To parse this JSON data, do
//
//     final tv = tvFromJson(jsonString);

import 'dart:convert';

Tv tvFromJson(String str) => Tv.fromJson(json.decode(str));

String tvToJson(Tv data) => json.encode(data.toJson());

class Tv {
    String originalName;
    List<int> genreIds;
    String name;
    double popularity;
    List<String> originCountry;
    int voteCount;
    DateTime firstAirDate;
    String backdropPath;
    String originalLanguage;
    int id;
    double voteAverage;
    String overview;
    String posterPath;

    Tv({
        this.originalName,
        this.genreIds,
        this.name,
        this.popularity,
        this.originCountry,
        this.voteCount,
        this.firstAirDate,
        this.backdropPath,
        this.originalLanguage,
        this.id,
        this.voteAverage,
        this.overview,
        this.posterPath,
    });

    factory Tv.fromJson(Map<String, dynamic> json) => new Tv(
        originalName: json["original_name"],
        genreIds: new List<int>.from(json["genre_ids"].map((x) => x)),
        name: json["name"],
        popularity: json["popularity"].toDouble(),
        // originCountry: new List<String>.from(json["origin_country"].map((x) => x)),
        voteCount: json["vote_count"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        backdropPath: json["backdrop_path"],
        originalLanguage: json["original_language"],
        id: json["id"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        posterPath: json["poster_path"],
    );

    Map<String, dynamic> toJson() => {
        "original_name": originalName,
        "genre_ids": new List<dynamic>.from(genreIds.map((x) => x)),
        "name": name,
        "popularity": popularity,
        "origin_country": new List<dynamic>.from(originCountry.map((x) => x)),
        "vote_count": voteCount,
        "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "backdrop_path": backdropPath,
        "original_language": originalLanguage,
        "id": id,
        "vote_average": voteAverage,
        "overview": overview,
        "poster_path": posterPath,
    };
}
