import 'package:education_game/models/media_model.dart';
import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final String? id;
  final String? name;
  final String? author;
  final String? description;
  final String? category;
  final num? maxLevel;
  final num? maxRetry;
  final num? maxTime;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<MediaModel>? images;

  GameModel({
    this.id,
    this.name,
    this.author,
    this.description,
    this.category,
    this.maxLevel,
    this.maxRetry,
    this.maxTime,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['_id'],
      name: json['name'],
      author: json['author'],
      description: json['description'],
      category: json['category'],
      maxLevel: json['maxLevel'],
      maxRetry: json['maxRetry'],
      maxTime: json['maxTime'],
      images: json['images'] == null
          ? null
          : List.from(json['images'])
              .map((e) => MediaModel.fromJson(e))
              .toList(),
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
        name,
        author,
        description,
        category,
        maxLevel,
        maxRetry,
        maxTime,
        images,
        deletedAt,
        createdAt,
        updatedAt,
      ];
}
