import 'package:equatable/equatable.dart';

class AyoBerhitung extends Equatable {
  final int level;
  final String image;
  final int number1;
  final int number2;
  final List<int> answers;
  final int answerKey;

  const AyoBerhitung({
    required this.level,
    required this.image,
    required this.number1,
    required this.number2,
    required this.answers,
    required this.answerKey,
  });

  @override
  List<Object?> get props => [
        level,
        image,
        number1,
        number2,
        answers,
        answerKey,
      ];
}
