import 'package:education_game/models/media_model.dart';
import 'package:equatable/equatable.dart';

class SchoolModel extends Equatable {
  final String? id;
  final String? name;
  final String? address;
  final num? adminsCount;
  final num? studentsCount;
  final DateTime? deletedAt;
  final List<MediaModel>? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SchoolModel({
    this.id,
    this.name,
    this.address,
    this.adminsCount,
    this.studentsCount,
    this.deletedAt,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      adminsCount: json['adminsCount'],
      studentsCount: json['studentsCount'],
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
        address,
        adminsCount,
        studentsCount,
        deletedAt,
        images,
        createdAt,
        updatedAt,
      ];
}
