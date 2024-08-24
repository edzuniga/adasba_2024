import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/indicadores_por_set.dart';
import 'package:adasba_2024/domain/repositories/indicadores_por_set_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener un registro en específico (por su ID)
class GetAllIndicadoresPorIdSet {
  final IndicadoresPorSetRepository repository;
  GetAllIndicadoresPorIdSet(this.repository);

  Future<Either<Failure, List<IndicadoresPorSet>>> call(int idSet) async {
    try {
      final listado = await repository.getAllIndicadoresPorIdSet(idSet);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddIndicadoresPorSet {
  final IndicadoresPorSetRepository repository;
  AddIndicadoresPorSet(this.repository);

  Future<Either<Failure, void>> call(
      IndicadoresPorSet indicadoresPorSet) async {
    try {
      await repository.addIndicadoresPorSet(indicadoresPorSet);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteIndicadoresPorSet {
  final IndicadoresPorSetRepository repository;
  DeleteIndicadoresPorSet(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteIndicadoresPorSet(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
