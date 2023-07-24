import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing_app/modules/auth/controllers/AuthController.dart';
import 'package:testing_app/modules/auth/dtos/login_credentials.dart';
import 'package:testing_app/modules/auth/repositories/auth_repository.dart';
import 'package:testing_app/modules/auth/usecases/login_usecase.dart';
import 'package:testing_app/modules/auth/entity/user.dart' as Us;
import 'package:testing_app/shared/exceptions/app_exceptions.dart';

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
  test("should call login and return useraccount", () async{
    Map<String, dynamic> jsonData = {
      'id': ID,
      'name': NAME,
      'email': EMAIL,
      'photo': PHOTO,
      'isAdmin': ISADMIN,
      'isFono': ISFONO,
    };

    final authRepository = AuthRepositoryMock();

    final loginUseCase = LoginUseCase(authRepository: authRepository);
    
    final credential = LoginCredentials.create(email: EMAIL, password: PASSWORD);
    when(()=>authRepository.login(loginCredentials: credential)).thenAnswer((_) async=> Us.User.fromJson(jsonData));
    
    final sut = AuthController(loginUseCase: loginUseCase);
    await sut.login(loginCredentials: credential);
    
    expect(sut.user.value, Us.User.fromJson(jsonData));
    verify(()=>authRepository.login(loginCredentials: credential) ).called(1);
  });
  test("should call login and return userNotFoundException", () async{
    Map<String, dynamic> jsonData = {
      'id': ID,
      'name': NAME,
      'email': EMAIL,
      'photo': PHOTO,
      'isAdmin': ISADMIN,
      'isFono': ISFONO,
    };

    final authRepository = AuthRepositoryMock();

    final loginUseCase = LoginUseCase(authRepository: authRepository);

    final credential = LoginCredentials.create(email: EMAIL, password: PASSWORD);
    when(()=>authRepository.login(loginCredentials: credential)).thenAnswer((_) async=> throw NotFoundException());

    final sut = AuthController(loginUseCase: loginUseCase);
    await sut.login(loginCredentials: credential);

    expect(sut.user.value, Us.User.empty());
    verify(()=>authRepository.login(loginCredentials: credential) ).called(1);
  });
}