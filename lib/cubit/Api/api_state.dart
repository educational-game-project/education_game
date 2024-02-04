part of 'api_cubit.dart';

class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiInitial extends ApiState {}

class ApiError extends ApiState {
  final BaseResponse data;
  ApiError(this.data);
}

class ApiLoading<T> extends ApiState {
  final ApiLoadingEnum? type;
  final T? additional;

  ApiLoading({
    this.type,
    this.additional,
  });
}

class LoginSuccess extends ApiState {
  final LoginParams params;
  final LoginResponses responses;
  LoginSuccess(this.params, this.responses);
}

class RefreshTokensSuccess extends ApiState {
  final RefreshTokenParams params;
  final RefreshTokensResponses responses;
  RefreshTokensSuccess(this.params, this.responses);
}
