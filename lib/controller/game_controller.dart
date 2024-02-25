import 'dart:async';

import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/enums/game/game_enum.dart';
import 'package:education_game/models/game_model.dart';
import 'package:education_game/models/leaderboard_model.dart';
import 'package:education_game/repositories/api_repository.dart';
import 'package:education_game/repositories/params/game_param.dart';
import 'package:education_game/repositories/responses/game_response.dart';
import 'package:education_game/views/pages/additional_pages/finish_page.dart';
import 'package:education_game/views/pages/additional_pages/leaderboard_page.dart';
import 'package:education_game/views/pages/additional_pages/lose_page.dart';
import 'package:education_game/views/pages/chooseGame/choose_game.dart';
import 'package:education_game/views/pages/game/berhitung/const/ayo_berhitung_const.dart';
import 'package:education_game/views/pages/game/berhitung/model/ayo_berhitung.dart';
import 'package:education_game/views/pages/game/game_page.dart';
import 'package:education_game/views/pages/game/kata/const/tebak_kata_const.dart';
import 'package:education_game/views/pages/game/kata/model/tebak_kata.dart';
import 'package:education_game/views/widgets/dialog/failded_dialog.dart';
import 'package:education_game/views/widgets/dialog/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class GameController extends GetxController {
  // variable
  final listGame = Rx<List<GameModel>>([]);
  final leaderboards = Rx<List<LeaderboardModel>>([]);
  final gameEnum = Rx(GameEnum.ayoBerhitung);
  final selectedLevel = Rx(1);
  final selectedGame = Rxn<GameModel>();

  final currentLevel = Rx(1);
  final liveLeft = Rx(3);
  final time = Rx(0);

  final isLoading = Rx(false);

  // set
  void setGameEnum(GameEnum value) {
    gameEnum.value = value;
    selectedGame.value = listGame.value.firstWhere(
      (e) => e.name?.toGameEnum == gameEnum.value,
    );
    debugPrint('setGameEnum : ${selectedGame.value}');
  }

  void setLevel(int level) {
    selectedLevel.value = level;
    reset();
  }

  void setLeaderboards(List<LeaderboardModel> value) {
    leaderboards.value = value;
  }

  void setLoading(bool value) => isLoading.value = value;

  var timer = Rxn<Timer>();

  void timeStart() {
    if (timer.value?.isActive ?? false) timer.value?.cancel();
    timer.value = Timer.periodic(const Duration(seconds: 1), (timer) {
      time.value = timer.tick;
    });
  }

  // Ayo berhitung
  AyoBerhitung get quest => AyoBerhitungConst.level(selectedLevel.value);
  final totalDragged = Rx<int>(0);
  final answer = Rxn<int>();
  void onDragged(int value) => totalDragged.value += value;
  void onAnswer(int value) {
    timer.value?.cancel();
    answer.value = value;
    onCek();
  }

  bool get isDraggedAll =>
      (quest.number1 + quest.number2) == totalDragged.value;

  // ======== Tebak Kata =========
  TebakKata get tebakKata => TebakKataConst.level(selectedLevel.value);
  final wordTebakKata = Rx<String>('');

  void onDraggedTebakKata(int index) {
    var cache = wordTebakKata.value.split('');
    cache.replaceWhere(
      (currentValue) => currentValue == '_',
      tebakKata.answer[index],
    );
  }

  void nextLevel() {
    reset();
    selectedLevel.value += 1;
    Get.off(() => const GamePage(), preventDuplicates: false);
  }

  void restartLevel() {
    reset();
    Get.off(() => const GamePage(), preventDuplicates: false);
  }

  void restartGame() {
    reset();
    Get.close(2);
    Get.off(() => const ChooseGame(), preventDuplicates: false);
  }

  void routeToLeaderboard() {
    Get.off(() => const LeaderBoardPage());
  }

  onCek() async {
    var param = GameParam(game: selectedGame.value?.id, time: time.value);
    var isValid = answer.value == quest.answerKey;
    await recordGame(param.copyWith(type: isValid ? 'Success' : 'Failed'));
    if (isValid) {
      currentLevel.value += 1;
      if (selectedLevel.value >= 3) {
        var res = await Get.dialog(const FinishPage());
        if (res ?? false) routeToLeaderboard();
      } else {
        var res = await Get.dialog(const SuccessDialog());
        if (res ?? false) nextLevel();
      }
    } else {
      liveLeft.value -= 1;
      if (liveLeft.value > 1) {
        var res = await Get.dialog(const FailedDialog());
        if (res ?? false) restartLevel();
      } else {
        var res = await Get.dialog(const LosePage());
        if (res ?? false) restartGame();
      }
    }
  }

  reset() {
    totalDragged.value = 0;
    answer.value = null;
    if (timer.value?.isActive ?? false) timer.value?.cancel();
    time.value = 0;
  }

  // global
  Function()? onContinue() {
    debugPrint('onContinue : ${gameEnum.value}');
    switch (gameEnum.value) {
      case GameEnum.ayoBerhitung:
        return null;
      case GameEnum.tebakGambar:
        return () {};
      case GameEnum.tebakKata:
        return () {};
      default:
        return null;
    }
  }

  List<LeaderboardModel> get listRanked {
    if (leaderboards.value.length == 1) return leaderboards.value;
    if (leaderboards.value.length == 2) {
      return [
        leaderboards.value[1],
        leaderboards.value[0],
      ];
    }
    return [
      leaderboards.value[1],
      leaderboards.value[0],
      leaderboards.value[2],
    ];
  }

  List<LeaderboardModel> get listRanked3Up {
    if (leaderboards.value.length <= 3) return [];
    return leaderboards.value.sublist(3);
  }

  // =========== API ===========

  ApiRepository apiRepository = ApiRepository();

  void _handleFailure(ApiError failure) {
    Get.snackbar('Failed to Load',
        failure.data.message ?? 'Something went wrong, Try again');
  }

  void _getListGameSuccess(GameResponse gameResponse) {
    listGame.value = gameResponse.listGame;
  }

  void _getLevelSuccess(GameResponse gameResponse) {
    currentLevel.value = (gameResponse.level.current ?? 1).toInt();
    liveLeft.value = (gameResponse.level.liveLeft ?? 1).toInt();
  }

  void _recordGameSuccess(GameResponse gameResponse) {
    //TODO
  }
  void _getLeaderBoardSuccess(GameResponse gameResponse) {
    //TODO
    debugPrint('set Leaderboard : ${gameResponse.leaderBoard}');
    leaderboards.value = gameResponse.leaderBoard;
  }

  Future<void> getListGame() async {
    setLoading(true);
    var param = const GameParam(author: "Iwan Suryaningrat");

    final resp = await apiRepository.getListGame(param);
    resp.fold(
      (failure) => _handleFailure(ApiError(failure)),
      (success) => _getListGameSuccess(success),
    );
    setLoading(false);
  }

  Future<void> getLevelGame() async {
    setLoading(true);
    var param = GameParam(id: selectedGame.value?.id);

    final resp = await apiRepository.getLevel(param);
    resp.fold(
      (failure) => _handleFailure(ApiError(failure)),
      (success) => _getLevelSuccess(success),
    );
    setLoading(false);
  }

  Future<void> recordGame(GameParam param) async {
    setLoading(true);

    final resp = await apiRepository.recordGame(param);
    resp.fold(
      (failure) => _handleFailure(ApiError(failure)),
      (success) => _recordGameSuccess(success),
    );
    setLoading(false);
  }

  Future<void> getLeaderBoardGame() async {
    setLoading(true);
    var param = GameParam(game: selectedGame.value?.id);

    final resp = await apiRepository.getLeaderBoard(param);
    resp.fold(
      (failure) => _handleFailure(ApiError(failure)),
      (success) => _getLeaderBoardSuccess(success),
    );
    setLoading(false);
  }

  // StreamSubscription? _apiCubitSubs;
  // final ApiCubit apiCubit = ApiCubit();

  // void getListGame() {
  //   apiCubit.getListGame(const GameParam(author: 'Iwan Suryaningrat'));
  // }

  // void getLevelGame() {
  //   apiCubit.getLevel(GameParam(id: selectedGame.value?.id));
  // }

  // void getLeaderBoardGame() {
  //   apiCubit.getLeaderBoard(GameParam(game: selectedGame.value?.id));
  // }

  // void recordGame(GameParam gameParam) {
  //   apiCubit.recordGame(gameParam);
  // }

  // @override
  // void onInit() {
  //   _apiCubitSubs = apiCubit.stream.listen((state) {
  //     debugPrint('$state');
  //     if (state is GetListGameSuccess) {
  //       debugPrint('${state.responses.listGame}');
  //     }
  //     if (state is GetLevelSuccess) {
  //       debugPrint('${state.responses.level}');
  //     }
  //     if (state is GetLeaderBoardSuccess) {
  //       debugPrint('${state.responses.leaderBoard}');
  //     }
  //     if (state is RecordGameSuccess) {
  //       debugPrint('${state.responses.record}');
  //     }
  //   });
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   _apiCubitSubs?.cancel();
  //   super.onClose();
  // }
}
