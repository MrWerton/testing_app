import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
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
  late final FirebaseAuth firebaseAuthMock;


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

  group("firebaseAuthImp", () {
    test("should do login correctly", () async {
      firebaseAuthMock = MockFirebaseAuth(mockUser: MockUser(email: EMAIL, displayName: NAME, photoURL: PHOTO, uid: ID));

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

      // Define a test that checks if the `signInWithEmailAndPassword` method returns
      // a successful response.
      test('signInWithEmailAndPassword returns a successful response', () async {
      MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
        // Mock the `signInWithEmailAndPassword` method to return a successful
        // response.
        when(()=>mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com', password: 'password') )
            .thenAnswer((_)async => MockUser());

        // Call the `signInWithEmailAndPassword` method.
        User user = (await mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com', password: 'password')) as User;

        // Assert that the user is not null.
        expect(user, isNotNull);



    });

  });
}