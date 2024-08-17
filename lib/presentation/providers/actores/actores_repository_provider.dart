import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/data/datasources/actor_datasource.dart';
import 'package:adasba_2024/data/repositories/actor_repository_impl.dart';
import 'package:adasba_2024/domain/usecases/actores_usecases.dart';
part 'actores_repository_provider.g.dart';

@Riverpod(keepAlive: true)
RemoteActorDataSource actoresDataSource(Ref ref) {
  return RemoteActorDataSource();
}

@Riverpod(keepAlive: true)
ActorRepositoryImpl actoresRepository(Ref ref) {
  final dataSource = ref.watch(actoresDataSourceProvider);
  return ActorRepositoryImpl(actorDataSource: dataSource);
}

//DESDE AQUÍ SE EMPIEZAN A CREAR LOS PROVIDERS PARA CADA UNO DE LOS CASOS
//*GET ALL REGISTROS
@riverpod
GetAllActores getAllActores(Ref ref) {
  final repository = ref.watch(actoresRepositoryProvider);
  return GetAllActores(repository);
}

//*GET SPECIFIC REGISTRO
@riverpod
GetSpecificActor getSpecificActor(Ref ref) {
  final repository = ref.watch(actoresRepositoryProvider);
  return GetSpecificActor(repository);
}

//*AGREGAR REGISTRO
@riverpod
AddActor addActor(Ref ref) {
  final repository = ref.watch(actoresRepositoryProvider);
  return AddActor(repository);
}

//*ACTUALIZAR REGISTRO
@riverpod
UpdateActor updateActor(Ref ref) {
  final repository = ref.watch(actoresRepositoryProvider);
  return UpdateActor(repository);
}

//*BORRAR REGISTRO
@riverpod
DeleteActor deleteActor(Ref ref) {
  final repository = ref.watch(actoresRepositoryProvider);
  return DeleteActor(repository);
}
