import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worstmovie/presentation/providers/movie_provider.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final _yearController = TextEditingController();
  bool? _winner;

  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).fetchMovies(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _yearController,
              decoration: InputDecoration(
                labelText: 'Filtrar por ano',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                int year = int.tryParse(value) ?? 0;
                movieProvider.fetchMovies(0, 10, year: year, winner: _winner);
              },
            ),
            SizedBox(height: 16),
            DropdownButton<bool>(
              value: _winner,
              hint: Text('Filtrar por vencedor'),
              onChanged: (value) {
                setState(() {
                  _winner = value;
                  movieProvider.fetchMovies(0, 10, year: int.tryParse(_yearController.text), winner: _winner);
                });
              },
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text('Todos'),
                ),
                DropdownMenuItem(
                  value: true,
                  child: Text('Vencedores'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('Não Vencedores'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Consumer<MovieProvider>(
                builder: (context, provider, child) {
                  if (provider.movies.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: provider.movies.length,
                      itemBuilder: (context, index) {
                        final movie = provider.movies[index];
                        return ListTile(
                          title: Text(movie.title),
                          subtitle: Text('Ano: ${movie.year}'),
                          trailing: movie.winner ? Icon(Icons.star, color: Colors.amber) : null,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
