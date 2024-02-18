import 'package:education_game/models/api/base_response.dart';
import 'package:equatable/equatable.dart';

class MainResponse extends Equatable {
  final BaseResponse baseResponse;

  const MainResponse(this.baseResponse);

  bool get isEmpty => baseResponse.data == null;

  bool get isSuccess =>
      baseResponse.statusCode == 200 || baseResponse.statusCode == 201;

  @override
  List<Object?> get props => [baseResponse];
}
