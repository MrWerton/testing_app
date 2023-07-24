import 'package:faker/faker.dart';
import 'package:testing_app/modules/auth/entity/user.dart';

class UserMock {
  late final String ID;
  late final String NAME;
  late final String EMAIL;
  late final String PHOTO;
  late final bool ISFONO;
  late final String PASSWORD;
  late final bool ISADMIN;

  UserMock() {
    final faker = Faker();
    ID = faker.guid.guid();
    NAME = faker.person.firstName();
    EMAIL = faker.internet.email();
    PHOTO = faker.internet.httpsUrl();
    PASSWORD = faker.internet.password();
    ISFONO = faker.randomGenerator.boolean();
    ISADMIN = faker.randomGenerator.boolean();
  }

   getUserJson(){
    Map<String, dynamic> jsonData = {
      'id': ID,
      'name': NAME,
      'email': EMAIL,
      'photo': PHOTO,
      'isAdmin': ISADMIN,
      'isFono': ISFONO,
    };
    return jsonData;
  }
  getUserModel(){
   User.fromJson(getUserJson());
  }
}