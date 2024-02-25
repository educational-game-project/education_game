import 'package:education_game/models/token_model.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:education_game/repositories/responses/main_response.dart';

class LoginResponses extends MainResponse {
  const LoginResponses(super.baseResponse) : super();

  UserModel get user {
    return isEmpty
        ? const UserModel()
        : UserModel.fromJson(baseResponse.data['user']);
  }

  TokensModel get tokens {
    return isEmpty
        ? const TokensModel()
        : TokensModel.fromJson(baseResponse.data['tokens']);
  }
}
