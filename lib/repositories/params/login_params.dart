import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String name;

  LoginParams({
    required this.name,
  });

  Map<String, dynamic> get toJson {
    return {'name': name};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
