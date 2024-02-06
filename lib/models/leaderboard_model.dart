import 'package:equatable/equatable.dart';
import 'package:education_game/models/user/user_model.dart';

class LeaderboardModel extends Equatable {
  final UserModel? user;
  final num? value;
  final bool? isCurrentUser;

  const LeaderboardModel({this.user, this.value, this.isCurrentUser});

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      value: json['value'],
      isCurrentUser: json['isCurrentUser'],
    );
  }

  @override
  List<Object?> get props => [user, value, isCurrentUser];
}
