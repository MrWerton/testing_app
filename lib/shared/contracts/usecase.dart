import 'package:equatable/equatable.dart';

abstract class UseCase<IN, OUT>{
  Future<OUT> call(IN data);
}

abstract class NoParams extends Equatable{}