import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/datasources/indicadores_por_set_datasource.dart';
import 'package:adasba_2024/data/repositories/indicadores_por_set_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/indicadores_por_set_usecases.dart';
part 'indicadores_por_set_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteIndicadoresPorSetDataSource indicadoresPorSetDataSource(Ref ref) {
  return RemoteIndicadoresPorSetDataSource();
}

@Riverpod(keepAlive: true)
IndicadoresPorSetRepositoryImpl indicadoresPorSetRepositoryImpl(Ref ref) {
  final dataSource = ref.watch(indicadoresPorSetDataSourceProvider);
  return IndicadoresPorSetRepositoryImpl(dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllIndicadoresPorIdSet getAllIndicadoresPorIdSet(Ref ref) {
  final repository = ref.watch(indicadoresPorSetRepositoryImplProvider);
  return GetAllIndicadoresPorIdSet(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddIndicadoresPorSet addIndicadoresPorSet(Ref ref) {
  final repository = ref.watch(indicadoresPorSetRepositoryImplProvider);
  return AddIndicadoresPorSet(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteIndicadoresPorSet deleteIndicadoresPorSet(Ref ref) {
  final repository = ref.watch(indicadoresPorSetRepositoryImplProvider);
  return DeleteIndicadoresPorSet(repository);
}
