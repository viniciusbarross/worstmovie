import 'package:worstmovie/domain/entities/movie.dart';

class MovieModel {
  final int id;
  final int year;
  final String title;
  final List<String> studios;
  final List<String> producers;
  final bool winner;

  MovieModel({
    required this.id,
    required this.year,
    required this.title,
    required this.studios,
    required this.producers,
    required this.winner,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      year: json['year'],
      title: json['title'],
      studios: List<String>.from(json['studios']),
      producers: List<String>.from(json['producers']),
      winner: json['winner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
      'title': title,
      'studios': studios,
      'producers': producers,
      'winner': winner,
    };
  }

  Movie toEntity() {
    return Movie(
      id: id,
      year: year,
      title: title,
      studios: studios,
      producers: producers,
      winner: winner,
    );
  }
}
