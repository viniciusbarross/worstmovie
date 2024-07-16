import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worstmovie/get_it.dart';
import 'package:worstmovie/presentation/pages/dashboard_page.dart';
import 'package:worstmovie/presentation/pages/movies_list_page.dart';
import 'package:worstmovie/presentation/providers/movie_provider.dart';
import 'package:worstmovie/presentation/providers/producer_provider.dart';
import 'package:worstmovie/presentation/providers/studio_provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator.get<MovieProvider>()),
        ChangeNotifierProvider(create: (_) => locator.get<StudioProvider>()),
        ChangeNotifierProvider(create: (_) => locator.get<ProducerProvider>()),
      ],
      child: MaterialApp(
        title: 'Golden Raspberry Awards',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Golden Raspberry Awards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              child: Text('Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoviesListPage()),
                );
              },
              child: Text('Lista de Filmes'),
            ),
          ],
        ),
      ),
    );
  }
}
