import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/datasources/compromiso_ley_datasource.dart';
import 'package:adasba_2024/data/repositories/compromiso_ley_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/compromiso_ley_usecases.dart';
part 'compromisos_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteCompromisoLeyDataSource compromisoLeyDataSource(Ref ref) {
  return RemoteCompromisoLeyDataSource();
}

@Riverpod(keepAlive: true)
CompromisoLeyRepositoryImpl compromisoLeyRepository(Ref ref) {
  final dataSource = ref.watch(compromisoLeyDataSourceProvider);
  return CompromisoLeyRepositoryImpl(compromisoLeyDataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllCompromisosLey getAllCompromisos(Ref ref) {
  final repository = ref.watch(compromisoLeyRepositoryProvider);
  return GetAllCompromisosLey(repository);
}

//*GET SPECIFIC REGISTRO
@riverpod
GetSpecificCompromisoLey getSpecificCompromisoLey(Ref ref) {
  final repository = ref.watch(compromisoLeyRepositoryProvider);
  return GetSpecificCompromisoLey(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddCompromisoLey addCompromiso(Ref ref) {
  final repository = ref.watch(compromisoLeyRepositoryProvider);
  return AddCompromisoLey(repository);
}

//*ACTUALIZAR REGISTRO
@riverpod
UpdateCompromisoLey updateCompromisoLey(Ref ref) {
  final repository = ref.watch(compromisoLeyRepositoryProvider);
  return UpdateCompromisoLey(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteCompromisoLey deleteCompromisoLey(Ref ref) {
  final repository = ref.watch(compromisoLeyRepositoryProvider);
  return DeleteCompromisoLey(repository);
}
