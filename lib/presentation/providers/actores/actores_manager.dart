import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/domain/entities/actor.dart';
import 'package:adasba_2024/presentation/providers/actores/actores_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';

part 'actores_manager.g.dart';

@riverpod
class ActoresManager extends _$ActoresManager {
  @override
  Future<List<Actor>> build() async {
    final storage = SecureStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<Actor> listado = [];
    final result =
        await ref.watch(getAllActoresProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(actoresManagerProvider.future);
  }
}
