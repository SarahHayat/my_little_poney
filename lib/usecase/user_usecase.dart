import 'package:my_little_poney/api/user_service_io.dart';
import 'package:my_little_poney/models/User.dart';

class UserUseCase {
  UserServiceApi api = UserServiceApi();

  Future<List<User>> getAllUser() async {
    return api.getAll().then((value) => value);
  }

  Future<User> fetchUserById(id) async {
    final result = await api.fetchUserById(id);
    return result;
  }

  Future<User> createUser(User user) async {
    return api.createUser(user).then((value) => value);
  }

  Future<User> updateUserById(user) async {
    return api.updateUser(user).then((value) => value);
  }

  Future<User?> deleteUserById(id) async {
   return api.deleteUser(id).then((value) => value);
  }

  Future<User> loggin(String email,String password) async {
    return api.loggin(email, password).then((value) => value).catchError((onError) => throw Exception('Failed to load user'));
  }

  Future<User> resetPassword(String email,String username) async {
    return api.resetPassword(email, username).then((value) => value).catchError((onError) => throw Exception('Failed to load user'));
  }
}
