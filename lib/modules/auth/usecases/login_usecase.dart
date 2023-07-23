import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/repositories/auth_repository.dart';
import 'package:testing_app/shared/contracts/usecase.dart';

import '../entity/user.dart';

class LoginUseCase implements UseCase<LoginCredentials, User? >{
  final AuthRepository _authRepository;

  LoginUseCase({required AuthRepository authRepository}): _authRepository= authRepository;

  @override
  Future<User?> call(LoginCredentials loginCredentials) async{
   return await _authRepository.login(loginCredentials: loginCredentials);
  }

}