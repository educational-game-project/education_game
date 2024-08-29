import 'package:equatable/equatable.dart';

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});

  Map<String, dynamic> get toJson {
    return {
      'refreshToken': refreshToken,
    };
  }

  @override
  List<Object?> get props => [refreshToken];
}
