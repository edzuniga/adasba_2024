import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/domain/entities/indicadores_por_set.dart';
import 'package:adasba_2024/presentation/providers/indicadores_por_set/indicadores_por_set_repository_provider.dart';

part 'indicadores_por_set_manager.g.dart';

@riverpod
class IndicadoresPorSetManager extends _$IndicadoresPorSetManager {
  @override
  Future<List<IndicadoresPorSet>> build(int idSet) async {
    List<IndicadoresPorSet> listado = [];
    final result =
        await ref.watch(getAllIndicadoresPorIdSetProvider).call(idSet);
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh(int idSet) {
    return ref.refresh(indicadoresPorSetManagerProvider(idSet).future);
  }
}
