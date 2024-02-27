import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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
import 'package:education_game/views/pages/game/gambar/const/tebak_gambar_const.dart';
import 'package:education_game/views/pages/game/gambar/model/tebak_gambar.dart';
import 'package:education_game/views/pages/game/game_page.dart';
import 'package:education_game/views/pages/game/kata/const/tebak_kata_const.dart';
import 'package:education_game/views/pages/game/kata/model/tebak_kata.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:education_game/views/widgets/dialog/failded_dialog.dart';
import 'package:education_game/views/widgets/dialog/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      (e) => e.gameEnum == gameEnum.value,
    );
    debugPrint('selectedGame : ${selectedGame.value}');
    debugPrint('selectedGame : ${listGame.value}');
    debugPrint('selectedGame : ${gameEnum.value}');
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
  AyoBerhitung get ayoBerhitung => AyoBerhitungConst.level(selectedLevel.value);
  final totalDraggedAyoBerhitung = Rx<int>(0);
  final answerAyoBerhitung = Rxn<int>();
  void onDragged(int value) => totalDraggedAyoBerhitung.value += value;
  void onAnswer(int value) {
    answerAyoBerhitung.value = value;
    onCek();
  }

  bool get isDraggedAll {
    return (ayoBerhitung.number1 + ayoBerhitung.number2) ==
        totalDraggedAyoBerhitung.value;
  }

  void resetAyoBerhitung() {
    totalDraggedAyoBerhitung.value = 0;
    answerAyoBerhitung.value = null;
  }

  // ======== Tebak Gambar =========
  TebakGambar get tebakGambar => TebakGambarConst.level(selectedLevel.value);
  StreamSubscription? audioSubs;
  var audioPlayer = AudioPlayer();
  var audioState = Rx(PlayerState.completed);
  var answerTebakGambar = Rx<String>('');

  void audioPlayPause() async {
    debugPrint('audio state : ${audioState.value}');
    switch (audioState.value) {
      case PlayerState.playing:
        return await audioPlayer.pause();
      case PlayerState.paused:
        return await audioPlayer.resume();
      default:
        return await audioPlayer.play(UrlSource(tebakGambar.audio));
    }
  }

  _setListenerAudion() {
    debugPrint('set listen audio : ${audioState.value}');
    audioSubs = audioPlayer.onPlayerStateChanged.listen((state) {
      audioState.value = state;
      debugPrint('state : ${audioState.value} : $state');
    });
  }

  initTebakGambar() {
    Future.delayed(Duration.zero, () => _setListenerAudion());
  }

  void onAnswerTebakGambar(String value) {
    answerTebakGambar.value = value;
  }

  audioStop() {
    if (audioState.value != PlayerState.stopped) audioPlayer.stop();
  }

  resetTebakGambar() {
    audioStop();
    audioState.value = PlayerState.completed;
    audioSubs?.cancel();
    answerTebakGambar.value = '';
  }

  // ======== Tebak Kata =========
  TebakKata get tebakKata => TebakKataConst.level(selectedLevel.value);
  final wordTebakKata = Rx<List<String>>([]);
  final answerTebakKata = Rx<List<String>>([]);

  initTebakKata() {
    setLoading(true);
    wordTebakKata.value = tebakKata.word;
    answerTebakKata.value = tebakKata.answer;
    setLoading(false);
  }

  void onDraggedTebakKata(int indexAnswer, int indexWord) {
    var cache = List<String>.from(wordTebakKata.value);
    cache[indexWord] = answerTebakKata.value[indexAnswer];
    wordTebakKata.value = cache;
  }

  void resetTebakKata() {
    wordTebakKata.value = [];
    answerTebakKata.value = [];
  }

  // ======= handling =========

  bool checkIfValid() {
    switch (gameEnum.value) {
      case GameEnum.ayoBerhitung:
        return answerAyoBerhitung.value == ayoBerhitung.answerKey;
      case GameEnum.tebakGambar:
        return answerTebakGambar.value == tebakGambar.answerKey;
      case GameEnum.tebakKata:
        return wordTebakKata.value.join() == tebakKata.answerKey;
    }
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
    // Get.close(3);
    Get.offAll(() => const HomePage());
    Get.to(() => const ChooseGame());
  }

  void routeToLeaderboard() {
    Get.off(() => const LeaderBoardPage());
  }

  bool isAnwered() {
    switch (gameEnum.value) {
      case GameEnum.ayoBerhitung:
        return isDraggedAll;
      case GameEnum.tebakGambar:
        return answerTebakGambar.isNotEmpty;
      case GameEnum.tebakKata:
        return !wordTebakKata.value.contains('_');
    }
  }

  onCek() async {
    if (isAnwered()) {
      timer.value?.cancel();
      audioStop();
      var param = GameParam(game: selectedGame.value?.id, time: time.value);
      var isValid = checkIfValid();
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
        if (liveLeft.value > 0) {
          var res = await Get.dialog(const FailedDialog());
          if (res ?? false) restartLevel();
        } else {
          var res = await Get.dialog(const LosePage());
          if (res ?? false) restartGame();
        }
      }
    }
  }

  reset() {
    switch (gameEnum.value) {
      case GameEnum.ayoBerhitung:
        return resetAyoBerhitung();
      case GameEnum.tebakGambar:
        return resetTebakGambar();
      case GameEnum.tebakKata:
        return resetTebakKata();
      default:
    }
    if (timer.value?.isActive ?? false) timer.value?.cancel();
    time.value = 0;
  }

  // global

  List<LeaderboardModel> get listRanked {
    return leaderboards.value;
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
    setLoading(false);
  }

  void _getListGameSuccess(GameResponse gameResponse) {
    listGame.value = gameResponse.listGame;
    setLoading(false);
  }

  void _getLevelSuccess(GameResponse gameResponse) {
    currentLevel.value = (gameResponse.level.current ?? 1).toInt();
    liveLeft.value = (gameResponse.level.liveLeft ?? 1).toInt();
    setLoading(false);
  }

  void _recordGameSuccess(GameResponse gameResponse) {
    //TODO
    setLoading(false);
  }

  void _getLeaderBoardSuccess(GameResponse gameResponse) {
    leaderboards.value = gameResponse.leaderBoard;
    setLoading(false);
  }

  Future<void> getListGame() async {
    setLoading(true);
    var param = const GameParam(author: "Iwan Suryaningrat");

    final resp = await apiRepository.getListGame(param);
    resp.fold(
      (failure) => _handleFailure(ApiError(failure)),
      (success) => _getListGameSuccess(success),
    );
  }

  Future<void> getLevelGame() async {
    setLoading(true);
    debugPrint('selected level : ${gameEnum.value}');
    debugPrint('selected level1 : ${listGame.value}');
    debugPrint('selected level2 : ${selectedGame.value}');
    var param = GameParam(id: selectedGame.value?.id);

    final resp = await apiRepository.getLevel(param);
    resp.fold(
      (failure) => _handleFailure(ApiError(failure)),
      (success) => _getLevelSuccess(success),
    );
  }

  Future<void> recordGame(GameParam param) async {
    setLoading(true);

    final resp = await apiRepository.recordGame(param);
    resp.fold(
      (failure) => _handleFailure(ApiError(failure)),
      (success) => _recordGameSuccess(success),
    );
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
}
