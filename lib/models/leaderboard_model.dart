import 'package:equatable/equatable.dart';
import 'package:education_game/models/user/user_model.dart';

class LeaderboardModel extends Equatable {
  final UserModel? user;
  final num? score;

  LeaderboardModel({this.user, this.score});

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
        score: json['score']);
  }

  @override
  List<Object?> get props => [user, score];
}
