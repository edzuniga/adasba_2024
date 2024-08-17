import 'package:adasba_2024/data/datasources/user_datasource.dart';
import 'package:adasba_2024/domain/entities/user.dart';
import 'package:adasba_2024/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource usersDataSource;

  UserRepositoryImpl({required this.usersDataSource});

  @override
  Future<void> addUser(User user) {
    return usersDataSource.addUser(user);
  }

  @override
  Future<void> deleteUser(int id) {
    return usersDataSource.deleteUser(id);
  }

  @override
  Future<List<User>> getAllUsers(String codaleaOrg) {
    return usersDataSource.getAllUsers(codaleaOrg);
  }

  @override
  Future<User> getSpecificUser(int id) {
    return usersDataSource.getSpecificUser(id);
  }

  @override
  Future<void> updateUser(User user) {
    return usersDataSource.updateUser(user);
  }
}
