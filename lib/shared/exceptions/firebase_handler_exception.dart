import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_app/shared/exceptions/app_exceptions.dart';


class FirebaseHandlerException {
  static AppException handleException(FirebaseException exception) {
    switch (exception.code) {
      case 'invalid-email':
      case 'user-not-found':
        return const  UnauthorizedException( code: 401,message:  'Invalid email or user not found');

      case 'wrong-password':
        return const UnauthorizedException( code: 401,message: 'Invalid password');

      case 'email-already-in-use':
        return const BadRequestException(code: 400,message: 'Email already in use');


      default:
        return const InternalServerErrorException(code: 500, message: 'An unknown error occurred');
    }
  }
}