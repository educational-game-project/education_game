import 'package:equatable/equatable.dart';

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  RefreshTokenParams({required this.refreshToken});

  Map<String, dynamic> get toJson {
    return {
      'refreshToken': refreshToken,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [refreshToken];
}
