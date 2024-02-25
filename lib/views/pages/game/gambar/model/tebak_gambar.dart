import 'package:equatable/equatable.dart';

class TebakGambar extends Equatable {
  final int level;
  final String audio;
  final List<String> answers;
  final String answerKey;

  const TebakGambar({
    required this.level,
    required this.audio,
    required this.answers,
    required this.answerKey,
  });

  @override
  List<Object?> get props => [
        level,
        audio,
        answers,
        answerKey,
      ];
}
