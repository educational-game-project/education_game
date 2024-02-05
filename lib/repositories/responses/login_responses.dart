import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/models/token_model.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:education_game/repositories/responses/main_response.dart';

class LoginResponses extends MainResponse {
  LoginResponses(super.baseResponse) : super();

  UserModel get user {
    return isEmpty
        ? UserModel()
        : UserModel.fromJson(baseResponse.data['user']);
  }

  TokensModel get tokens {
    return isEmpty
        ? TokensModel()
        : TokensModel.fromJson(baseResponse.data['tokens']);
  }
}
