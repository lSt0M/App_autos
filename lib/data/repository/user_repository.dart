import 'package:valet_parking_app/data/models/user_model.dart';
import 'package:valet_parking_app/data/repository/repository_constants.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  UserRepository._internal();

  final RepositoryConstants _repo = RepositoryConstants();

  Future<User?> createUser(User user, bool isAdmin) async {
    final result = await _repo.sendPost(
      '/api/auth/new',
      user.toJson(),
      isAuth: isAdmin,
    );
    if ([200, 201].contains(result.statusCode)) {
      final Map<String, dynamic> body = result.data;
      return User.fromJson(body['user']);
    }
    return null;
  }

  Future<User?> loginCredentials(String email, String password) async {
    final result = await _repo.sendPost(
      '/api/auth/',
      {'email': email, 'password': password},
      isAuth: false,
    );
    if ([200, 201].contains(result.statusCode)) {
      final Map<String, dynamic> body = result.data;
      return User.fromJson(body['user']);
    }
    return null;
  }
}
