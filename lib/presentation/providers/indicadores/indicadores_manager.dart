import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/domain/entities/indicador.dart';
import 'package:adasba_2024/presentation/providers/indicadores/indicadores_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';

part 'indicadores_manager.g.dart';

@riverpod
class IndicadoresManager extends _$IndicadoresManager {
  @override
  Future<List<Indicador>> build() async {
    final storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<Indicador> listado = [];
    final result =
        await ref.watch(getAllIndicadoresProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(indicadoresManagerProvider.future);
  }
}
