import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/datasources/proyecto_datasource.dart';
import 'package:adasba_2024/data/repositories/proyecto_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/proyectos_usecases.dart';

part 'proyectos_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteProyectoDataSource proyectosDataSource(Ref ref) {
  return RemoteProyectoDataSource();
}

@Riverpod(keepAlive: true)
ProyectoRepositoryImpl proyectosRepository(Ref ref) {
  final dataSource = ref.watch(proyectosDataSourceProvider);
  return ProyectoRepositoryImpl(proyectoDataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllProyectos getAllProyectos(Ref ref) {
  final repository = ref.watch(proyectosRepositoryProvider);
  return GetAllProyectos(repository);
}

//*GET SPECIFIC REGISTRO
@riverpod
GetSpecificProyecto getSpecificProyecto(Ref ref) {
  final repository = ref.watch(proyectosRepositoryProvider);
  return GetSpecificProyecto(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddProyecto addProyecto(Ref ref) {
  final repository = ref.watch(proyectosRepositoryProvider);
  return AddProyecto(repository);
}

//*ACTUALIZAR REGISTRO
@riverpod
UpdateProyecto updateProyecto(Ref ref) {
  final repository = ref.watch(proyectosRepositoryProvider);
  return UpdateProyecto(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteProyecto deleteProyecto(Ref ref) {
  final repository = ref.watch(proyectosRepositoryProvider);
  return DeleteProyecto(repository);
}
