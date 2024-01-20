import 'package:education_game/models/media_model.dart';
import 'package:education_game/models/school/school_model.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? role;
  final String? email;
  final String? phoneNumber;
  final MediaModel? image;
  final SchoolModel? school;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.role,
    this.email,
    this.phoneNumber,
    this.image,
    this.school,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      image: json['image'] == null ? null : MediaModel.fromJson(json['image']),
      school:
          json['school'] == null ? null : SchoolModel.fromJson(json['school']),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.tryParse(json['deletedAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        email,
        phoneNumber,
        deletedAt,
        image,
        school,
      ];
}
