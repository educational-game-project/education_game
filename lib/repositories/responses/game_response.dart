import 'package:education_game/models/game_model.dart';
import 'package:education_game/models/leaderboard_model.dart';
import 'package:education_game/models/level_model.dart';
import 'package:education_game/models/record_model.dart';
import 'package:education_game/repositories/responses/main_response.dart';

class GameResponse extends MainResponse {
  const GameResponse(super.baseResponse) : super();

  List<GameModel> get listGame {
    return isEmpty
        ? []
        : List.from(baseResponse.data).map((e) {
            return GameModel.fromJson(e);
          }).toList();
  }

  LevelModel get level {
    return isEmpty
        ? const LevelModel()
        : LevelModel.fromJson(baseResponse.data);
  }

  RecordModel get record {
    return isEmpty
        ? const RecordModel()
        : RecordModel.fromJson(baseResponse.data);
  }

  List<LeaderboardModel> get leaderBoard {
    return isEmpty
        ? []
        : List.from(baseResponse.data['leaderboard']).map((e) {
            return LeaderboardModel.fromJson(e);
          }).toList();
  }
}
