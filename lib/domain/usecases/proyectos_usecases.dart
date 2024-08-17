import 'package:dartz/dartz.dart';

import 'package:adasba_2024/domain/entities/proyecto.dart';
import 'package:adasba_2024/domain/repositories/proyecto_repository.dart';
import 'package:adasba_2024/utilities/error_manager.dart';

//Obtener todos los registros
class GetAllProyectos {
  final ProyectoRepository repository;
  GetAllProyectos(this.repository);

  Future<Either<Failure, List<Proyecto>>> call(String codaleaOrg) async {
    try {
      final listado = await repository.getAllProyectos(codaleaOrg);
      return Right(listado);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar los registros: $e'));
    }
  }
}

//Obtener un registro en específico (por su ID)
class GetSpecificProyecto {
  final ProyectoRepository repository;
  GetSpecificProyecto(this.repository);

  Future<Either<Failure, Proyecto>> call(int id) async {
    try {
      final proyecto = await repository.getSpecificProyecto(id);
      return Right(proyecto);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al cargar el registro: $e'));
    }
  }
}

//Agregar un nuevo registro
class AddProyecto {
  final ProyectoRepository repository;
  AddProyecto(this.repository);

  Future<Either<Failure, void>> call(Proyecto proyecto) async {
    try {
      await repository.addProyecto(proyecto);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al agregar registro: $e'));
    }
  }
}

//Actualizar UN registro
class UpdateProyecto {
  final ProyectoRepository repository;
  UpdateProyecto(this.repository);

  Future<Either<Failure, void>> call(Proyecto proyecto) async {
    try {
      await repository.updateProyecto(proyecto);
      return const Right(null);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Error al actualizar el registro: $e'));
    }
  }
}

//Borrar UN registro
class DeleteProyecto {
  final ProyectoRepository repository;
  DeleteProyecto(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    try {
      await repository.deleteProyecto(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al borrar registro: $e'));
    }
  }
}
