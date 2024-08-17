import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/datasources/grupo_datasource.dart';
import 'package:adasba_2024/data/repositories/grupo_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/grupos_usecases.dart';

part 'grupos_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteGrupoDataSource grupoDataSource(Ref ref) {
  return RemoteGrupoDataSource();
}

@Riverpod(keepAlive: true)
GrupoRepositoryImpl gruposRepository(Ref ref) {
  final dataSource = ref.watch(grupoDataSourceProvider);
  return GrupoRepositoryImpl(gruposDataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL GRUPOS
@riverpod
GetAllGrupos getAllGrupos(Ref ref) {
  final repository = ref.watch(gruposRepositoryProvider);
  return GetAllGrupos(repository);
}

//*GET SPECIFIC GRUPO
@riverpod
GetSpecificGrupo getSpecificGrupo(Ref ref) {
  final repository = ref.watch(gruposRepositoryProvider);
  return GetSpecificGrupo(repository);
}

//*AGREGAR GRUPO
@riverpod
AddGrupo addGrupo(Ref ref) {
  final repository = ref.watch(gruposRepositoryProvider);
  return AddGrupo(repository);
}

//*ACTUALIZAR GRUPO
@riverpod
UpdateGrupo updateGrupo(Ref ref) {
  final repository = ref.watch(gruposRepositoryProvider);
  return UpdateGrupo(repository);
}

//*BORRAR GRUPO
@riverpod
DeleteGrupo deleteGrupo(Ref ref) {
  final repository = ref.watch(gruposRepositoryProvider);
  return DeleteGrupo(repository);
}
