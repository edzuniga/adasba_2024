import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/compromiso_ley.dart';
import 'package:adasba_2024/domain/repositories/compromiso_ley_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllCompromisosLey {
  final CompromisoLeyRepository repository;
  GetAllCompromisosLey(this.repository);

  Future<Either<Failure, List<CompromisoLey>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllCompromisosLey(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificCompromisoLey {
  final CompromisoLeyRepository repository;
  GetSpecificCompromisoLey(this.repository);

  Future<Either<Failure, CompromisoLey>> call(int id) async {
    try {
      final actor = await repository.getSpecificCompromisoLey(id);
      return Right(actor);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddCompromisoLey {
  final CompromisoLeyRepository repository;
  AddCompromisoLey(this.repository);

  Future<Either<Failure, void>> call(CompromisoLey compromisoLey) async {
    try {
      await repository.addCompromisoLey(compromisoLey);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateCompromisoLey {
  final CompromisoLeyRepository repository;
  UpdateCompromisoLey(this.repository);

  Future<Either<Failure, void>> call(CompromisoLey compromisoLey) async {
    try {
      await repository.updateCompromisoLey(compromisoLey);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteCompromisoLey {
  final CompromisoLeyRepository repository;
  DeleteCompromisoLey(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteCompromisoLey(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
