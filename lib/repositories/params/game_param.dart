import 'package:equatable/equatable.dart';

class GameParam extends Equatable {
  final String? id;
  final String? author;
  final String? game;
  final String? type;
  final num? time;
  const GameParam({
    this.id,
    this.author,
    this.game,
    this.type,
    this.time,
  });
  @override
  List<Object?> get props => [
        id,
        author,
        game,
        type,
        time,
      ];

  GameParam copyWith({
    String? id,
    String? author,
    String? game,
    String? type,
    num? time,
  }) {
    return GameParam(
      id: id ?? this.id,
      author: author ?? this.author,
      game: game ?? this.game,
      type: type ?? this.type,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> get toJson {
    return {
      if (id != null) 'id': id,
      if (author != null) 'author': author,
      if (game != null) 'game': game,
      if (type != null) 'type': type,
      if (time != null) 'time': time,
    };
  }
}
