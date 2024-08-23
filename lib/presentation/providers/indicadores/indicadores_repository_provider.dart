import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/datasources/indicador_datasource.dart';
import 'package:adasba_2024/data/repositories/indicador_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/indicadores_usecases.dart';
part 'indicadores_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteIndicadorDataSource indicadorDataSource(Ref ref) {
  return RemoteIndicadorDataSource();
}

@Riverpod(keepAlive: true)
IndicadorRepositoryImpl indicadorRepositoryImpl(Ref ref) {
  final dataSource = ref.watch(indicadorDataSourceProvider);
  return IndicadorRepositoryImpl(dataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllIndicadores getAllIndicadores(Ref ref) {
  final repository = ref.watch(indicadorRepositoryImplProvider);
  return GetAllIndicadores(repository);
}

//*GET SPECIFIC REGISTRO
@riverpod
GetSpecificIndicador getSpecificIndicador(Ref ref) {
  final repository = ref.watch(indicadorRepositoryImplProvider);
  return GetSpecificIndicador(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddIndicador addIndicador(Ref ref) {
  final repository = ref.watch(indicadorRepositoryImplProvider);
  return AddIndicador(repository);
}

//*ACTUALIZAR REGISTRO
@riverpod
UpdateIndicador updateIndicador(Ref ref) {
  final repository = ref.watch(indicadorRepositoryImplProvider);
  return UpdateIndicador(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteIndicador deleteIndicador(Ref ref) {
  final repository = ref.watch(indicadorRepositoryImplProvider);
  return DeleteIndicador(repository);
}
