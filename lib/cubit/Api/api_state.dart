part of 'api_cubit.dart';

class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiInitial extends ApiState {}

class ApiError extends ApiState {
  final BaseResponse data;

  const ApiError(this.data);
}

class ApiLoading<T> extends ApiState {
  final ApiLoadingEnum? type;
  final T? additional;

  const ApiLoading({
    this.type,
    this.additional,
  });
}

class LoginSuccess extends ApiState {
  final LoginParams params;
  final LoginResponses responses;
  const LoginSuccess(this.params, this.responses);
}

class LogoutSuccess extends ApiState {
  final LoginResponses responses;
  const LogoutSuccess(this.responses);
}

class RefreshTokensSuccess extends ApiState {
  final RefreshTokenParams params;
  final RefreshTokensResponses responses;
  const RefreshTokensSuccess(this.params, this.responses);
}

class GetListGameSuccess extends ApiState {
  final GameParam params;
  final GameResponse responses;
  const GetListGameSuccess(this.params, this.responses);
}

class GetLevelSuccess extends ApiState {
  final GameParam params;
  final GameResponse responses;
  const GetLevelSuccess(this.params, this.responses);
}

class GetLeaderBoardSuccess extends ApiState {
  final GameParam params;
  final GameResponse responses;
  const GetLeaderBoardSuccess(this.params, this.responses);
}

class RecordGameSuccess extends ApiState {
  final GameParam params;
  final GameResponse responses;
  const RecordGameSuccess(this.params, this.responses);
}
