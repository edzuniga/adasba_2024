import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/grupo_beneficiario.dart';
import 'package:adasba_2024/domain/repositories/grupo_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllGrupos {
  final GrupoRepository repository;
  GetAllGrupos(this.repository);

  Future<Either<Failure, List<Grupo>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllGrupos(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registro: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificGrupo {
  final GrupoRepository repository;
  GetSpecificGrupo(this.repository);

  Future<Either<Failure, Grupo>> call(int id) async {
    try {
      final grupo = await repository.getSpecificGrupo(id);
      return Right(grupo);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddGrupo {
  final GrupoRepository repository;

  AddGrupo(this.repository);

  Future<Either<Failure, void>> call(Grupo grupo) async {
    try {
      await repository.addGrupo(grupo);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateGrupo {
  final GrupoRepository repository;
  UpdateGrupo(this.repository);

  Future<Either<Failure, void>> call(Grupo grupo) async {
    try {
      await repository.updateGrupo(grupo);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteGrupo {
  final GrupoRepository repository;
  DeleteGrupo(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteGrupo(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
