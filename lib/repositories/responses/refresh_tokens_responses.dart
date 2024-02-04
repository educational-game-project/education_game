import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/models/token_model.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class RefreshTokensResponses extends Equatable {
  final BaseResponse baseResponse;

  RefreshTokensResponses(this.baseResponse);

  bool get isEmpty {
    return baseResponse.data == null;
  }

  TokensModel get tokens {
    return isEmpty
        ? TokensModel()
        : TokensModel.fromJson(baseResponse.data['tokens']);
  }

  UserModel get user {
    return isEmpty
        ? UserModel()
        : UserModel.fromJson(baseResponse.data['user']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [baseResponse];
}
