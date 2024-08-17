import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/user.dart';
import 'package:adasba_2024/domain/repositories/user_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllUsers {
  final UserRepository repository;
  GetAllUsers(this.repository);

  Future<Either<Failure, List<User>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllUsers(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificUser {
  final UserRepository repository;
  GetSpecificUser(this.repository);

  Future<Either<Failure, User>> call(int id) async {
    try {
      final user = await repository.getSpecificUser(id);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddUser {
  final UserRepository repository;
  AddUser(this.repository);

  Future<Either<Failure, void>> call(User user) async {
    try {
      await repository.addUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);

  Future<Either<Failure, void>> call(User user) async {
    try {
      await repository.updateUser(user);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteUser {
  final UserRepository repository;
  DeleteUser(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteUser(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
