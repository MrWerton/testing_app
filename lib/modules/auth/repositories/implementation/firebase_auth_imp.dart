
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/entity/user.dart' as UserEntity;
import 'package:testing_app/modules/auth/repositories/auth_repository.dart';
import 'package:testing_app/shared/exceptions/app_exceptions.dart';
import 'package:testing_app/shared/exceptions/firebase_handler_exception.dart';

class FirebaseAuthImp extends AuthRepository{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthImp({required FirebaseAuth firebaseAuth, required FirebaseFirestore firestore}): _firebaseAuth = firebaseAuth, _firebaseFirestore =firestore ;

  @override
  Future<UserEntity.User?> login({required LoginCredentials loginCredentials})async {
   try{
     final response = await _firebaseAuth.signInWithEmailAndPassword(email: loginCredentials.email, password: loginCredentials.password);
     final userEmail = response.user?.email;

    return _getUser(email: userEmail!);

   }on FirebaseException catch(err){
    throw FirebaseHandlerException.handleException(err);
   }
  }

  Future<UserEntity.User?> _getUser({required String email})async{
    final response = await _firebaseFirestore.collection('users').where('email', isEqualTo: email).get();
    final userData = response.docs.firstOrNull;
    if(userData == null){
      return null;
    }

    return UserEntity.User.fromJson(userData.data());
  }

}