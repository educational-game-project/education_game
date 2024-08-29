import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String name;

  const LoginParams({
    required this.name,
  });

  Map<String, dynamic> get toJson {
    return {'name': name};
  }

  @override
  List<Object?> get props => [name];
}
