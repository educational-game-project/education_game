import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum TokenEnum {
  accoessToken,
  refreshToken,
}

class TokensModel extends Equatable {
  final String accoessToken;
  final String refreshToken;
  final _storage = const FlutterSecureStorage();

  TokensModel({
    this.accoessToken = '',
    this.refreshToken = '',
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      accoessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Future<TokensModel> read() async {
    final accoessToken =
        await _storage.read(key: TokenEnum.accoessToken.name) ?? '';
    final refreshToken =
        await _storage.read(key: TokenEnum.refreshToken.name) ?? '';
    return TokensModel(refreshToken: refreshToken, accoessToken: accoessToken);
  }

  void save() {
    _storage.write(
      key: TokenEnum.accoessToken.name,
      value: accoessToken,
    );
    _storage.write(
      key: TokenEnum.refreshToken.name,
      value: refreshToken,
    );
  }

  void remove() {
    _storage.delete(
      key: TokenEnum.accoessToken.name,
    );
    _storage.delete(
      key: TokenEnum.refreshToken.name,
    );
  }

  @override
  List<Object?> get props => [accoessToken, refreshToken];

  bool get isAuthenticated {
    return accoessToken != '' && refreshToken != '';
  }

  TokensModel copyWith({
    String? accoessToken,
    String? refreshToken,
  }) {
    return TokensModel(
      accoessToken: accoessToken ?? this.accoessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
