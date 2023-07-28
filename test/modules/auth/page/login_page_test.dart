import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_app/modules/auth/controllers/AuthController.dart';
import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/entity/user.dart';
import 'package:testing_app/modules/auth/pages/auth_page.dart';
import 'package:testing_app/modules/auth/repositories/auth_repository.dart';
import 'package:testing_app/modules/auth/usecases/login_usecase.dart';

class AuthRepositoryMock extends Mock implements AuthRepository{}
void main(){
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
  });
  testWidgets("should call login and return useraccount", (WidgetTester tester) async{
    final authRepository = AuthRepositoryMock();
    final loginUseCase = LoginUseCase(authRepository: authRepository);

    final authController = AuthController(loginUseCase: loginUseCase);

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(authController: authController),
      ),
    );
    Map<String, dynamic> jsonData = {
      'id': ID,
      'name': NAME,
      'email': EMAIL,
      'photo': PHOTO,
      'isAdmin': false,
      'isFono': ISFONO,
    };

    await tester.enterText(find.byType(TextFormField).at(0), EMAIL);
    await tester.enterText(find.byType(TextFormField).at(1), PASSWORD);


    when(()=>authRepository.login(loginCredentials: LoginCredentials.create(email: EMAIL, password: PASSWORD))).thenAnswer((_) async=> User.fromJson(jsonData));

    await tester.tap(find.text('login'));
    await tester.pump();

    expect(authController.user.value, User.fromJson(jsonData));
  });

}