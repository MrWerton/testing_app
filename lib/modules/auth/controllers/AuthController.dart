import 'package:flutter/cupertino.dart';
import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/entity/user.dart';
import 'package:testing_app/modules/auth/usecases/login_usecase.dart';
import 'package:testing_app/shared/exceptions/app_exceptions.dart';

class AuthController extends ChangeNotifier{
  final LoginUseCase loginUseCase;

  final ValueNotifier<User> user = ValueNotifier(User.empty());
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  AuthController({required this.loginUseCase});


  Future<void> login({required LoginCredentials loginCredentials}) async{
    isLoading.value = true;
    try{
      final userResponse = await loginUseCase.call(loginCredentials);
      print(userResponse);
     if(userResponse != null){
       user.value = userResponse;
     }
    }on AppException catch(err){
      print(err.message);
    }finally{
      isLoading.value = false;
    }
  }


}