import 'package:education_game/models/game_model.dart';
import 'package:equatable/equatable.dart';

class RecordModel extends Equatable {
  final num? level;
  final List<num>? time;
  final num? liveLeft;
  final num? count;
  final String? status;
  final String? isValid;
  final String? deletedAt;
  final String? user;
  final GameModel? game;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? v;

  const RecordModel({
    this.level,
    this.time,
    this.liveLeft,
    this.count,
    this.status,
    this.isValid,
    this.deletedAt,
    this.user,
    this.game,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  List<Object?> get props => [
        level,
        time,
        liveLeft,
        count,
        status,
        isValid,
        deletedAt,
        user,
        game,
        id,
        createdAt,
        updatedAt,
        v,
      ];

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      level: json['level'],
      time: json['time'],
      liveLeft: json['liveLeft'],
      count: json['count'],
      status: json['status'],
      isValid: json['isValid'],
      deletedAt: json['deletedAt'],
      user: json['user'],
      game: json['game'] == null ? null : GameModel.fromJson(json['game']),
      id: json['id'],
      createdAt:
          json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      v: json['v'],
    );
  }
}
