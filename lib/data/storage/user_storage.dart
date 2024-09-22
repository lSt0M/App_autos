import 'package:valet_parking_app/data/models/user_model.dart';
import 'package:valet_parking_app/data/storage/valet_storage.dart';

class UserStorage {
  static final UserStorage _ins = UserStorage._();
  factory UserStorage() => _ins;
  UserStorage._();

  final ValetStorage _storage = ValetStorage();

  Future saveUser(User user) async {
    await Future.wait([
      _storage.setItem('name', user.name),
      _storage.setItem('email', user.email),
      _storage.setItem('dni', user.dni),
      _storage.setItem('phone', user.phone),
      _storage.setItem('token', user.token),
    ]);
  }

  Future<String> getAccessToken() async {
    return await _storage.getItem('token') ?? '';
  }

  Future<User?> getUser() async {
    final name = await _storage.getItem('name');
    final email = await _storage.getItem('email');
    final dni = await _storage.getItem('dni');
    final phone = await _storage.getItem('phone');
    final token = await _storage.getItem('token');

    return name != null && email != null && dni != null && phone != null
        ? User(
            name: name,
            email: email,
            dni: dni,
            phone: phone,
            token: token,
          )
        : null;
  }

  Future removeUser() async {
    await Future.wait([
      _storage.removeItem('name'),
      _storage.removeItem('email'),
      _storage.removeItem('dni'),
      _storage.removeItem('phone'),
      _storage.removeItem('token'),
    ]);
  }

  Future<void> clear() async {
    await _storage.clear();
  }
}
