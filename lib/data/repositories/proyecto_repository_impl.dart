import 'package:adasba_2024/data/datasources/proyecto_datasource.dart';
import 'package:adasba_2024/domain/entities/proyecto.dart';
import 'package:adasba_2024/domain/repositories/proyecto_repository.dart';

class ProyectoRepositoryImpl implements ProyectoRepository {
  final ProyectoDataSource proyectoDataSource;

  ProyectoRepositoryImpl({required this.proyectoDataSource});

  @override
  Future<void> addProyecto(Proyecto proyecto) {
    return proyectoDataSource.addProyecto(proyecto);
  }

  @override
  Future<void> deleteProyecto(int id) {
    return proyectoDataSource.deleteProyecto(id);
  }

  @override
  Future<List<Proyecto>> getAllProyectos(String codaleaOrg) {
    return proyectoDataSource.getAllProyectos(codaleaOrg);
  }

  @override
  Future<Proyecto> getSpecificProyecto(int id) {
    return proyectoDataSource.getSpecificProyecto(id);
  }

  @override
  Future<void> updateProyecto(Proyecto proyecto) {
    return proyectoDataSource.updateProyecto(proyecto);
  }
}
