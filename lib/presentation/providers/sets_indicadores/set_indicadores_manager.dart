import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/domain/entities/set_indicador.dart';
import 'package:adasba_2024/presentation/providers/sets_indicadores/set_indicadores_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';

part 'set_indicadores_manager.g.dart';

@riverpod
class SetIndicadoresManager extends _$SetIndicadoresManager {
  @override
  Future<List<SetIndicador>> build() async {
    final storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<SetIndicador> listado = [];
    final result = await ref
        .watch(getAllSetIndicadoresProvider)
        .call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(setIndicadoresManagerProvider.future);
  }
}
