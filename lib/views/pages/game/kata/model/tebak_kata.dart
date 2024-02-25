import 'package:equatable/equatable.dart';

class TebakKata extends Equatable {
  final int level;
  final List<String> word;
  final List<String> answer;
  final String answerKey;
  const TebakKata({
    required this.level,
    required this.word,
    required this.answer,
    required this.answerKey,
  });
  @override
  List<Object?> get props => [
        level,
        word,
        answer,
        answerKey,
      ];
}
