import 'package:equatable/equatable.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:education_game/models/game_model.dart';

class LevelModel extends Equatable {
  final String? id;
  final num? current;
  final num? max;
  final num? liveLeft;
  final bool? isValid;
  final UserModel? user;
  final GameModel? game;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const LevelModel({
    this.id,
    this.current,
    this.max,
    this.liveLeft,
    this.isValid,
    this.user,
    this.game,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['_id'],
      current: json['current'],
      max: json['max'],
      liveLeft: json['liveLeft'],
      isValid: json['isValid'],
      user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      game: json['game'] == null ? null : GameModel.fromJson(json['game']),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.tryParse(json['deletedAt']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        current,
        max,
        liveLeft,
        isValid,
        user,
        game,
        deletedAt,
        createdAt,
        updatedAt,
      ];
}
