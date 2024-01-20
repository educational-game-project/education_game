import 'package:equatable/equatable.dart';

class MediaModel extends Equatable {
  final String? id;
  final String? originalName;
  final String? fileName;
  final String? fileLink;
  final String? mimeType;
  final num? size;
  final bool? isDefault;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MediaModel({
    this.id,
    this.originalName,
    this.fileName,
    this.fileLink,
    this.mimeType,
    this.size,
    this.isDefault,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['_id'],
      originalName: json['originalName'],
      fileName: json['fileName'],
      fileLink: json['fileLink'],
      mimeType: json['mimeType'],
      size: json['size'],
      isDefault: json['isDefault'],
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
        originalName,
        fileName,
        fileLink,
        mimeType,
        size,
        isDefault,
        deletedAt,
        createdAt,
        updatedAt,
      ];

  MediaModel copyWith({
    String? id,
    String? originalName,
    String? fileName,
    String? fileLink,
    String? mimeType,
    num? size,
    bool? isDefault,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MediaModel(
        id: id ?? this.id,
        originalName: originalName ?? this.originalName,
        fileName: fileName ?? this.fileName,
        fileLink: fileLink ?? this.fileLink,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
        isDefault: isDefault ?? this.isDefault,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}
