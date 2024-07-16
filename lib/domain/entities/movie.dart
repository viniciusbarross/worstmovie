class Movie {
  final int id;
  final int year;
  final String title;
  final List<String> studios;
  final List<String> producers;
  final bool winner;

  Movie({
    required this.id,
    required this.year,
    required this.title,
    required this.studios,
    required this.producers,
    required this.winner,
  });
}
