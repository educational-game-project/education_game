import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum TokenEnum {
  token,
  refreshToken,
}

class TokenModel extends Equatable {
  final String? token;
  final String? refreshToken;
  final _storage = const FlutterSecureStorage();

  TokenModel({
    this.token,
    this.refreshToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Future<TokenModel> get read async {
    final token = await _storage.read(key: TokenEnum.token.name);
    final refreshToken = await _storage.read(key: TokenEnum.refreshToken.name);
    return TokenModel(refreshToken: refreshToken, token: token);
  }

  void get save {
    _storage.write(key: TokenEnum.token.name, value: token);
    _storage.write(key: TokenEnum.refreshToken.name, value: refreshToken);
  }

  @override
  List<Object?> get props => [token, refreshToken];

  TokenModel copyWith({
    String? token,
    String? refreshToken,
  }) {
    return TokenModel(
      token: token,
      refreshToken: refreshToken,
    );
  }
}
