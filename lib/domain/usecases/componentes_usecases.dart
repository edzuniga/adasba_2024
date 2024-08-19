import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/componente.dart';
import 'package:adasba_2024/domain/repositories/componente_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllComponentes {
  final ComponenteRepository repository;
  GetAllComponentes(this.repository);

  Future<Either<Failure, List<Componente>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllComponentes(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificComponente {
  final ComponenteRepository repository;
  GetSpecificComponente(this.repository);

  Future<Either<Failure, Componente>> call(int id) async {
    try {
      final proyecto = await repository.getSpecificComponente(id);
      return Right(proyecto);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddComponente {
  final ComponenteRepository repository;
  AddComponente(this.repository);

  Future<Either<Failure, void>> call(Componente componente) async {
    try {
      await repository.addComponente(componente);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateComponente {
  final ComponenteRepository repository;
  UpdateComponente(this.repository);

  Future<Either<Failure, void>> call(Componente componente) async {
    try {
      await repository.updateComponente(componente);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteComponente {
  final ComponenteRepository repository;
  DeleteComponente(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteComponente(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
