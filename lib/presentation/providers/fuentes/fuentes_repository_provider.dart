import 'package:adasba_2024/data/datasources/fuente_datasource.dart';
import 'package:adasba_2024/data/repositories/fuente_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/fuentes_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fuentes_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteFuenteDataSource fuenteDataSource(Ref ref) {
  return RemoteFuenteDataSource();
}

@Riverpod(keepAlive: true)
FuenteRepositoryImpl fuenteRepositoryImpl(Ref ref) {
  final dataSource = ref.watch(fuenteDataSourceProvider);
  return FuenteRepositoryImpl(dataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllFuentes getAllFuentes(Ref ref) {
  final repository = ref.watch(fuenteRepositoryImplProvider);
  return GetAllFuentes(repository);
}

//*GET SPECIFIC REGISTRO
@riverpod
GetSpecificFuente getSpecificFuente(Ref ref) {
  final repository = ref.watch(fuenteRepositoryImplProvider);
  return GetSpecificFuente(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddFuente addFuente(Ref ref) {
  final repository = ref.watch(fuenteRepositoryImplProvider);
  return AddFuente(repository);
}

//*ACTUALIZAR REGISTRO
@riverpod
UpdateFuente updateFuente(Ref ref) {
  final repository = ref.watch(fuenteRepositoryImplProvider);
  return UpdateFuente(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteFuente deleteFuente(Ref ref) {
  final repository = ref.watch(fuenteRepositoryImplProvider);
  return DeleteFuente(repository);
}
