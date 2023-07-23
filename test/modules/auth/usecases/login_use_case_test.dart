import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/entity/user.dart';
import 'package:testing_app/modules/auth/repositories/auth_repository.dart';
import 'package:testing_app/modules/auth/usecases/login_usecase.dart';

class AuthRepositoryMock extends Mock implements AuthRepository{}
void main(){
  late final AuthRepository authRepository;
  late final String email ;
  late  final String password ;
  late final LoginCredentials loginCredentials;
  late final String ID;
  late final String NAME;
  late final String EMAIL;
  late final String PHOTO;
  late final bool ISFONO;

  setUpAll(() {
    ID = faker.guid.guid();
    NAME = faker.person.firstName();
    EMAIL = faker.internet.email();
    PHOTO = faker.internet.httpsUrl();
    ISFONO = faker.randomGenerator.boolean();
    authRepository = AuthRepositoryMock();
    email = faker.internet.email();
    password = faker.internet.password();
    loginCredentials = LoginCredentials.create(email: email, password: password);

  });

   group("login_useCase", () {
    test("should login correctly", () async{
      final sut = LoginUseCase(authRepository: authRepository);
      final userMock =   User.create(id: ID, name: NAME, email: EMAIL, photo: PHOTO, isFono: ISFONO);
      when(()=>authRepository.login(loginCredentials: loginCredentials)).thenAnswer((_) async=> userMock);
      final response =await sut.call(loginCredentials);


      expect(response, userMock);
      verify(()=>authRepository.login(loginCredentials: loginCredentials)).called(1);
    });

   });
}