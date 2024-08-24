import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/set_indicador.dart';
import 'package:adasba_2024/domain/repositories/set_indicador_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllSetIndicadores {
  final SetIndicadoresRepository repository;
  GetAllSetIndicadores(this.repository);

  Future<Either<Failure, List<SetIndicador>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllSetIndicadores(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificSetIndicadores {
  final SetIndicadoresRepository repository;
  GetSpecificSetIndicadores(this.repository);

  Future<Either<Failure, SetIndicador>> call(int id) async {
    try {
      final setIndicador = await repository.getSpecificSetIndicador(id);
      return Right(setIndicador);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddSetIndicadores {
  final SetIndicadoresRepository repository;
  AddSetIndicadores(this.repository);

  Future<Either<Failure, void>> call(SetIndicador setIndicador) async {
    try {
      await repository.addSetIndicador(setIndicador);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateSetIndicadores {
  final SetIndicadoresRepository repository;
  UpdateSetIndicadores(this.repository);

  Future<Either<Failure, void>> call(SetIndicador setIndicador) async {
    try {
      await repository.updateSetIndicador(setIndicador);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteSetIndicadores {
  final SetIndicadoresRepository repository;
  DeleteSetIndicadores(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteSetIndicador(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
