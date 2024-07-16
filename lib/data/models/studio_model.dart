import 'package:worstmovie/domain/entities/studio.dart';

class StudioModel {
  final String name;
  final int winCount;

  StudioModel({required this.name, required this.winCount});

  factory StudioModel.fromJson(Map<String, dynamic> json) {
    return StudioModel(
      name: json['name'],
      winCount: json['winCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'winCount': winCount,
    };
  }

  factory StudioModel.fromEntity(Studio studio) {
    return StudioModel(
      name: studio.name,
      winCount: studio.winCount,
    );
  }
  Studio toEntity() {
    return Studio(
      name: name,
      winCount: winCount,
    );
  }
}
