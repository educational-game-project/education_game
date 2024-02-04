import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/models/token_model.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

class LoginResponses extends Equatable {
  final BaseResponse baseResponse;

  const LoginResponses(this.baseResponse);

  UserModel get user {
    return baseResponse.data == null
        ? const UserModel()
        : UserModel.fromJson(baseResponse.data['user']);
  }

  TokensModel get tokens {
    return baseResponse.data == null
        ? const TokensModel()
        : TokensModel.fromJson(baseResponse.data['tokens']);
  }

  @override
  List<Object?> get props => [baseResponse];
}
