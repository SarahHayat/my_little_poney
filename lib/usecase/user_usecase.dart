import 'package:my_little_poney/api/user_service_io.dart';
import 'package:my_little_poney/models/User.dart';

class UserUseCase {
  UserServiceApi api = UserServiceApi();

  Future<List<User>?> getAllUser() async {
    api.getAll().then((value) => value);
  }

  Future<User?> fetchUserById(id) async {
    api.fetchUserById(id).then((value) => value);
  }

  Future<User?> loggin(String email,String password) async {
    api.loggin(email, password).then((value) => value).catchError((onError) => throw Exception('Failed to load user'));
  }
}
