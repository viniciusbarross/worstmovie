import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worstmovie/presentation/providers/movie_provider.dart';
import 'package:worstmovie/presentation/providers/producer_provider.dart';
import 'package:worstmovie/presentation/providers/studio_provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchInitialData();
    });
  }

  void fetchInitialData() {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final studioProvider = Provider.of<StudioProvider>(context, listen: false);
    final producerProvider = Provider.of<ProducerProvider>(context, listen: false);

    movieProvider.fetchMoviesWithMultipleWinners();
    studioProvider.fetchStudios();
    producerProvider.fetchProducers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMoviesSection(),
              SizedBox(height: 16),
              buildStudiosSection(),
              SizedBox(height: 16),
              buildProducersSection(),
              SizedBox(height: 16),
              buildMoviesByYearSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMoviesSection() {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Anos com mais de um vencedor:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (movieProvider.isLoading) CircularProgressIndicator(),
            if (!movieProvider.isLoading && movieProvider.yearsWithMultipleWinners.isEmpty) Text('Nenhum dado encontrado.'),
            if (!movieProvider.isLoading && movieProvider.yearsWithMultipleWinners.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Ano')),
                    DataColumn(label: Text('Quantidade de Vencedores')),
                  ],
                  rows: movieProvider.yearsWithMultipleWinners.map((yearData) {
                    return DataRow(cells: [
                      DataCell(Text(yearData.year.toString())),
                      DataCell(Text(yearData.winnerCount.toString())),
                    ]);
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildStudiosSection() {
    return Consumer<StudioProvider>(
      builder: (context, studioProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estúdios com mais vitórias:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (studioProvider.isLoading) CircularProgressIndicator(),
            if (!studioProvider.isLoading && studioProvider.studios.isEmpty) Text('Nenhum dado encontrado.'),
            if (!studioProvider.isLoading && studioProvider.studios.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Estúdio')),
                    DataColumn(label: Text('Vitórias')),
                  ],
                  rows: studioProvider.studios.map((studio) {
                    return DataRow(cells: [
                      DataCell(Text(studio.name)),
                      DataCell(Text(studio.winCount.toString())),
                    ]);
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildProducersSection() {
    return Consumer<ProducerProvider>(
      builder: (context, producerProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Produtores com maior intervalo entre vitórias:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (producerProvider.isLoading) CircularProgressIndicator(),
            if (!producerProvider.isLoading && producerProvider.maxProducers.isEmpty) Text('Nenhum dado encontrado.'),
            if (!producerProvider.isLoading && producerProvider.maxProducers.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Produtor')),
                    DataColumn(label: Text('Intervalo')),
                    DataColumn(label: Text('Primeira Vitória')),
                    DataColumn(label: Text('Última Vitória')),
                  ],
                  rows: producerProvider.maxProducers.map((producer) {
                    return DataRow(cells: [
                      DataCell(Text(producer.producer)),
                      DataCell(Text(producer.interval.toString())),
                      DataCell(Text(producer.previousWin.toString())),
                      DataCell(Text(producer.followingWin.toString())),
                    ]);
                  }).toList(),
                ),
              ),
            SizedBox(height: 16),
            Text('Produtores com menor intervalo entre vitórias:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (!producerProvider.isLoading && producerProvider.minProducers.isEmpty) Text('Nenhum dado encontrado.'),
            if (!producerProvider.isLoading && producerProvider.minProducers.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Produtor')),
                    DataColumn(label: Text('Intervalo')),
                    DataColumn(label: Text('Primeira Vitória')),
                    DataColumn(label: Text('Última Vitória')),
                  ],
                  rows: producerProvider.minProducers.map((producer) {
                    return DataRow(cells: [
                      DataCell(Text(producer.producer)),
                      DataCell(Text(producer.interval.toString())),
                      DataCell(Text(producer.previousWin.toString())),
                      DataCell(Text(producer.followingWin.toString())),
                    ]);
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildMoviesByYearSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vencedores por ano:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextField(
          decoration: InputDecoration(
            labelText: 'Ano',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          onSubmitted: (value) async {
            if (value.isNotEmpty) {
              int year = int.parse(value);
              final movieProvider = Provider.of<MovieProvider>(context, listen: false);
              await movieProvider.fetchMoviesByYear(year);
            }
          },
        ),
        SizedBox(height: 16),
        Consumer<MovieProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return CircularProgressIndicator();
            } else if (provider.moviesByYear.isEmpty) {
              return Text('Nenhum vencedor encontrado para o ano especificado');
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Título')),
                    DataColumn(label: Text('Estúdios')),
                    DataColumn(label: Text('Produtores')),
                  ],
                  rows: provider.moviesByYear.map((movie) {
                    return DataRow(cells: [
                      DataCell(Text(movie.title)),
                      DataCell(Text(movie.studios.join(', '))),
                      DataCell(Text(movie.producers.join(', '))),
                    ]);
                  }).toList(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
