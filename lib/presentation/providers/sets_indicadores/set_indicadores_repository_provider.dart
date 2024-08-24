import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/datasources/set_indicadores_datasource.dart';
import 'package:adasba_2024/data/repositories/set_indicadores_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/set_indicadores_usecases.dart';
part 'set_indicadores_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteSetIndicadoresDataSource setIndicadoresDataSource(Ref ref) {
  return RemoteSetIndicadoresDataSource();
}

@Riverpod(keepAlive: true)
SetIndicadoresRepositoryImpl setIndicadoresRepositoryImpl(Ref ref) {
  final dataSource = ref.watch(setIndicadoresDataSourceProvider);
  return SetIndicadoresRepositoryImpl(dataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllSetIndicadores getAllSetIndicadores(Ref ref) {
  final repository = ref.watch(setIndicadoresRepositoryImplProvider);
  return GetAllSetIndicadores(repository);
}

//*GET SPECIFIC REGISTRO
@riverpod
GetSpecificSetIndicadores getSpecificSetIndicador(Ref ref) {
  final repository = ref.watch(setIndicadoresRepositoryImplProvider);
  return GetSpecificSetIndicadores(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddSetIndicadores addSetIndicadores(Ref ref) {
  final repository = ref.watch(setIndicadoresRepositoryImplProvider);
  return AddSetIndicadores(repository);
}

//*ACTUALIZAR REGISTRO
@riverpod
UpdateSetIndicadores updateSetIndicadores(Ref ref) {
  final repository = ref.watch(setIndicadoresRepositoryImplProvider);
  return UpdateSetIndicadores(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteSetIndicadores deleteSetIndicadores(Ref ref) {
  final repository = ref.watch(setIndicadoresRepositoryImplProvider);
  return DeleteSetIndicadores(repository);
}
