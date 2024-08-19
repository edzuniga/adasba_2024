import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/indicador.dart';
import 'package:adasba_2024/domain/repositories/indicador_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllIndicadores {
  final IndicadorRepository repository;
  GetAllIndicadores(this.repository);

  Future<Either<Failure, List<Indicador>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllIndicadores(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificIndicador {
  final IndicadorRepository repository;
  GetSpecificIndicador(this.repository);

  Future<Either<Failure, Indicador>> call(int id) async {
    try {
      final indicador = await repository.getSpecificIndicador(id);
      return Right(indicador);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddIndicador {
  final IndicadorRepository repository;
  AddIndicador(this.repository);

  Future<Either<Failure, void>> call(Indicador indicador) async {
    try {
      await repository.addIndicador(indicador);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateIndicador {
  final IndicadorRepository repository;
  UpdateIndicador(this.repository);

  Future<Either<Failure, void>> call(Indicador indicador) async {
    try {
      await repository.updateIndicador(indicador);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteIndicador {
  final IndicadorRepository repository;
  DeleteIndicador(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteIndicador(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
