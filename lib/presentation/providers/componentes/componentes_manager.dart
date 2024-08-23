import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/domain/entities/componente.dart';
import 'package:adasba_2024/presentation/providers/componentes/componentes_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';

part 'componentes_manager.g.dart';

@riverpod
class ComponentesManager extends _$ComponentesManager {
  @override
  Future<List<Componente>> build() async {
    final storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<Componente> listado = [];
    final result =
        await ref.watch(getAllComponentesProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(componentesManagerProvider.future);
  }
}
