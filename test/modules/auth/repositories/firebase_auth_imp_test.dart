import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:testing_app/modules/auth/entity/user.dart' as Us;
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/repositories/implementation/firebase_auth_imp.dart';
import 'package:testing_app/shared/exceptions/app_exceptions.dart';



void main(){
  late final FirebaseFirestore firestoreMock;


  late final String ID;
  late final String NAME;
  late final String EMAIL;
  late final String PHOTO;
  late final bool ISFONO;
  late final String PASSWORD;
  late final bool ISADMIN;



  setUpAll(() {
    ID = faker.guid.guid();
    NAME = faker.person.firstName();
    EMAIL = faker.internet.email();
    PHOTO = faker.internet.httpsUrl();
    PASSWORD = faker.internet.password();
    ISFONO = faker.randomGenerator.boolean();
    ISADMIN = faker.randomGenerator.boolean();
    firestoreMock = FakeFirebaseFirestore();


  });

  group("firebase Auth Implemenation", () {
    test("should do login correctly", () async {
      final firebaseAuthMock = MockFirebaseAuth(mockUser: MockUser(email: EMAIL, displayName: NAME, photoURL: PHOTO, uid: ID));

      final sut = FirebaseAuthImp(firebaseAuth: firebaseAuthMock, firestore: firestoreMock);
      Map<String, dynamic> jsonData = {
        'id': ID,
        'name': NAME,
        'email': EMAIL,
        'photo': PHOTO,
        'isAdmin': ISADMIN,
        'isFono': ISFONO,
      };

     await firestoreMock.collection("users").add(jsonData);

     final credential = LoginCredentials.create(email: EMAIL, password: PASSWORD);

     final response = await sut.login(loginCredentials: credential);

     expect(response, Us.User.fromJson(jsonData));


    });
    test("should return app failure", () async {
      final firebaseAuthMock = MockFirebaseAuth(mockUser: MockUser(email: EMAIL, displayName: NAME, photoURL: PHOTO, uid: ID));

      final sut = FirebaseAuthImp(firebaseAuth: firebaseAuthMock, firestore: firestoreMock);
      Map<String, dynamic> jsonData = {
        'id': ID,
        'name': NAME,
        'email': EMAIL,
        'photo': PHOTO,
        'isAdmin': ISADMIN,
        'isFono': ISFONO,
      };

      await firestoreMock.collection("users").add(jsonData);

      whenCalling(Invocation.method(#signInWithEmailAndPassword, null)).on(firebaseAuthMock).thenThrow(FirebaseAuthException(code: "user-not-found"));
      final credential = LoginCredentials.create(email: EMAIL, password: PASSWORD);

      expect(sut.login(loginCredentials: credential), throwsA(isA<AppException>()));

    });


  });
}