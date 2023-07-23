import 'package:equatable/equatable.dart';

class LoginCredentials extends Equatable{
  final String email;
  final String password;

   LoginCredentials._({required this.email, required this.password});

   factory LoginCredentials.create({required String email, required String password}){
     return  LoginCredentials._(email: email, password: password);
   }

  @override
  List<Object?> get props => [email, password];


  Map<String, dynamic> toJson(){
    return{
      'email': email,
      'passoword': password
    };
  }

}