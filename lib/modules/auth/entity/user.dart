import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String _name;
  final String _id;
  final String _email;
  final String _photo;
  final bool _isAdmin;
  final bool _isFono;

  const User._({
    required String id,
    required String name,
    required String email,
    required String photo,
    required bool isAdmin,
    required bool isFono,
  })  :_id = id,
        _name = name,
        _email = email,
        _photo = photo,
        _isAdmin = isAdmin,
        _isFono = isFono;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get photo => _photo;
  bool get isAdmin => _isAdmin;
  bool get isFono => _isFono;

  factory User.create({
    required String id,
    required String name,
    required String email,
    required String photo,
    required bool isFono,
  }) {
    return User._(
      id: id,
      name: name,
      email: email,
      photo: photo,
      isAdmin: false,
      isFono: isFono,
    );
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User._(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photo: map['photo'],
      isAdmin: map['isAdmin'] ?? false,
      isFono: map['isFono'] ?? false,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'photo': _photo,
      'isAdmin': _isAdmin,
      'isFono': _isFono,
    };
  }

  @override
  List<Object?> get props => [_id, _name, _email, _photo, _isAdmin, _isFono];

}
