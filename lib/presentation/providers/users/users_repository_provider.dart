import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/repositories/user_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/users_usecases.dart';
import 'package:adasba_2024/data/datasources/user_datasource.dart';

part 'users_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteUserDataSource usersDataSource(Ref ref) {
  return RemoteUserDataSource();
}

@Riverpod(keepAlive: true)
UserRepositoryImpl usersRepository(Ref ref) {
  final dataSource = ref.watch(usersDataSourceProvider);
  return UserRepositoryImpl(usersDataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL USERS
@riverpod
GetAllUsers getAllUsers(Ref ref) {
  final repository = ref.watch(usersRepositoryProvider);
  return GetAllUsers(repository);
}

//*GET SPECIFIC User
@riverpod
GetSpecificUser getSpecificUser(Ref ref) {
  final repository = ref.watch(usersRepositoryProvider);
  return GetSpecificUser(repository);
}

//*AGREGAR User
@riverpod
AddUser addUser(Ref ref) {
  final repository = ref.watch(usersRepositoryProvider);
  return AddUser(repository);
}

//*ACTUALIZAR User
@riverpod
UpdateUser updateUser(Ref ref) {
  final repository = ref.watch(usersRepositoryProvider);
  return UpdateUser(repository);
}

//*BORRAR User
@riverpod
DeleteUser deleteUser(Ref ref) {
  final repository = ref.watch(usersRepositoryProvider);
  return DeleteUser(repository);
}
