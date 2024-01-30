part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final ApiState? apiState;

  final AuthStatus status;
  final TokensModel? tokens;
  final UserModel? user;

  AuthState._({
    required this.status,
    this.apiState,
    this.tokens,
    this.user,
  });

  factory AuthState.unauthenticated() {
    return AuthState._(
      status: AuthStatus.unauthenticated,
    );
  }

  factory AuthState.authenticated({
    TokensModel? tokens,
    UserModel? user,
  }) {
    return AuthState._(
      status: AuthStatus.authenticated,
      user: user,
      tokens: tokens,
    );
  }

  @override
  List<Object?> get props => [
        tokens,
        status,
        user,
        apiState,
      ];

  AuthState copyWith({
    TokensModel? tokens,
    UserModel? user,
    ApiState? apiState,
  }) {
    return AuthState._(
      status: status,
      tokens: tokens ?? this.tokens,
      user: user ?? this.user,
      apiState: apiState ?? this.apiState,
    );
  }
}
