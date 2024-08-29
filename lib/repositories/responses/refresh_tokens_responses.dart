import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/models/token_model.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class RefreshTokensResponses extends Equatable {
  final BaseResponse baseResponse;

  const RefreshTokensResponses(this.baseResponse);

  bool get isEmpty {
    return baseResponse.data == null;
  }

  TokensModel get tokens {
    return isEmpty
        ? const TokensModel()
        : TokensModel.fromJson(baseResponse.data['tokens']);
  }

  UserModel get user {
    return isEmpty
        ? const UserModel()
        : UserModel.fromJson(baseResponse.data['user']);
  }

  @override
  List<Object?> get props => [baseResponse];
}
