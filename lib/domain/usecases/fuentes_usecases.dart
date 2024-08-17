import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/fuente.dart';
import 'package:adasba_2024/domain/repositories/fuente_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

class GetAllFuentes {
  final FuenteRepository repository;
  GetAllFuentes(this.repository);

  //Obtener todos los registros
  Future<Either<Failure, List<Fuente>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllFuentes(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificFuente {
  final FuenteRepository repository;
  GetSpecificFuente(this.repository);

  Future<Either<Failure, Fuente>> call(int id) async {
    try {
      final actor = await repository.getSpecificFuente(id);
      return Right(actor);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddFuente {
  final FuenteRepository repository;
  AddFuente(this.repository);

  Future<Either<Failure, void>> call(Fuente fuente) async {
    try {
      await repository.addFuente(fuente);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateFuente {
  final FuenteRepository repository;
  UpdateFuente(this.repository);

  Future<Either<Failure, void>> call(Fuente fuente) async {
    try {
      await repository.updateFuente(fuente);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteFuente {
  final FuenteRepository repository;
  DeleteFuente(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteFuente(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
