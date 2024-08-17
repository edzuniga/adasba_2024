//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers(String codaleaOrg);
  Future<User> getSpecificUser(int id);
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
}
