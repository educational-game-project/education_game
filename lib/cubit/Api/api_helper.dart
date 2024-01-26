import 'package:education_game/models/user/user_model.dart';

enum ApiLoadingEnum {
  regular,
  login;

  get additionalType {
    switch (this) {
      case ApiLoadingEnum.regular:
        return dynamic;
      case ApiLoadingEnum.login:
        return UserModel;
    }
  }
}
