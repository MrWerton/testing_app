import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/modules/auth/entity/user.dart';

void main(){
  late final String ID;
  late final String NAME;
  late final String EMAIL;
  late final String PHOTO;
  late final bool ISFONO;
  late final bool ISADMIN;

  setUpAll(() {
     ID = faker.guid.guid();
     NAME = faker.person.firstName();
     EMAIL = faker.internet.email();
     PHOTO = faker.internet.httpsUrl();
     ISFONO = faker.randomGenerator.boolean();
     ISADMIN = faker.randomGenerator.boolean();

  });

  group('User entity', () {
    test("should be initialized with correctly params", () {

    final sut = User.create(id: ID, name: NAME, email: EMAIL, photo: PHOTO, isFono: ISFONO);

    expect(NAME, sut.name);
    expect(EMAIL, sut.email);
    expect(PHOTO, sut.photo);
    expect(ISFONO, sut.isFono);
    expect(false, sut.isAdmin);
    });
  });

  test("should parse of json to model correctly", () {
    Map<String, dynamic> jsonData = {
      'id': ID,
      'name': NAME,
      'email': EMAIL,
      'photo': PHOTO,
      'isAdmin': ISADMIN,
      'isFono': ISFONO,
    };

    User user = User.fromJson(jsonData);

    expect(ID, user.id);
    expect(NAME, user.name);
    expect(EMAIL, user.email);
    expect(PHOTO, user.photo);
    expect(ISFONO, user.isFono);
    expect(false, user.isAdmin);
  });

  test("should parse of model to json correctly", () {
    Map<String, dynamic> JSONMOCK = {
      'id': ID,
      'name': NAME,
      'email': EMAIL,
      'photo': PHOTO,
      'isAdmin': ISADMIN,
      'isFono': ISFONO,
    };
    final user = User.create(id: ID, name: NAME, email: EMAIL, photo: PHOTO, isFono: ISFONO);
    final sut = user.toJson();

    expect(JSONMOCK['id'], user.id);
    expect(JSONMOCK['name'], user.name);
    expect(JSONMOCK['email'], user.email);
    expect(JSONMOCK['photo'], user.photo);
    expect(JSONMOCK['isFono'], user.isFono);
    expect(JSONMOCK['isAdmin'], user.isAdmin);
    expect(JSONMOCK, sut);
  });
}