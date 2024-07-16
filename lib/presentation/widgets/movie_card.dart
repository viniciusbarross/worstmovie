import 'package:flutter/material.dart';
import 'package:worstmovie/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text('Year: ${movie.year}'),
        trailing: movie.winner ? Icon(Icons.star, color: Colors.yellow) : null,
      ),
    );
  }
}
