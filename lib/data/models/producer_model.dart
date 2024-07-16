import 'package:worstmovie/domain/entities/producer.dart';

class ProducerModel {
  final String producer;
  final int interval;
  final int previousWin;
  final int followingWin;

  ProducerModel({
    required this.producer,
    required this.interval,
    required this.previousWin,
    required this.followingWin,
  });

  factory ProducerModel.fromJson(Map<String, dynamic> json) {
    return ProducerModel(
      producer: json['producer'],
      interval: json['interval'],
      previousWin: json['previousWin'],
      followingWin: json['followingWin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'producer': producer,
      'interval': interval,
      'previousWin': previousWin,
      'followingWin': followingWin,
    };
  }

  factory ProducerModel.fromEntity(Producer producer) {
    return ProducerModel(
      producer: producer.producer,
      interval: producer.interval,
      previousWin: producer.previousWin,
      followingWin: producer.followingWin,
    );
  }
  Producer toEntity() {
    return Producer(
      producer: producer,
      interval: interval,
      previousWin: previousWin,
      followingWin: followingWin,
    );
  }
}
