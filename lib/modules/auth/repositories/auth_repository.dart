import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/entity/user.dart';

abstract class AuthRepository{
  Future<User?> login({required LoginCredentials loginCredentials});
}