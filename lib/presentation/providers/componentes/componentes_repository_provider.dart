import 'package:adasba_2024/data/datasources/componente_datasource.dart';
import 'package:adasba_2024/data/repositories/componente_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/componentes_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'componentes_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteComponenteDataSource componenteDataSource(Ref ref) {
  return RemoteComponenteDataSource();
}

@Riverpod(keepAlive: true)
ComponenteRepositoryImpl componenteRepositoryImpl(Ref ref) {
  final dataSource = ref.watch(componenteDataSourceProvider);
  return ComponenteRepositoryImpl(dataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllComponentes getAllComponentes(Ref ref) {
  final repository = ref.watch(componenteRepositoryImplProvider);
  return GetAllComponentes(repository);
}

//*GET SPECIFIC REGISTRO
@riverpod
GetSpecificComponente getSpecificComponente(Ref ref) {
  final repository = ref.watch(componenteRepositoryImplProvider);
  return GetSpecificComponente(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddComponente addComponente(Ref ref) {
  final repository = ref.watch(componenteRepositoryImplProvider);
  return AddComponente(repository);
}

//*ACTUALIZAR REGISTRO
@riverpod
UpdateComponente updateComponente(Ref ref) {
  final repository = ref.watch(componenteRepositoryImplProvider);
  return UpdateComponente(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteComponente deleteComponente(Ref ref) {
  final repository = ref.watch(componenteRepositoryImplProvider);
  return DeleteComponente(repository);
}
