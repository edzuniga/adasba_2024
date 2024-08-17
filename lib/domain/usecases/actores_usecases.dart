import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/actor.dart';
import 'package:adasba_2024/domain/repositories/actor_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllActores {
  final ActorRepository repository;
  GetAllActores(this.repository);

  Future<Either<Failure, List<Actor>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllActores(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificActor {
  final ActorRepository repository;
  GetSpecificActor(this.repository);

  Future<Either<Failure, Actor>> call(int id) async {
    try {
      final actor = await repository.getSpecificActor(id);
      return Right(actor);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddActor {
  final ActorRepository repository;
  AddActor(this.repository);

  Future<Either<Failure, void>> call(Actor actor) async {
    try {
      await repository.addActor(actor);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateActor {
  final ActorRepository repository;
  UpdateActor(this.repository);

  Future<Either<Failure, void>> call(Actor actor) async {
    try {
      await repository.updateActor(actor);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteActor {
  final ActorRepository repository;
  DeleteActor(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteActor(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
