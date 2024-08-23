import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/domain/entities/compromiso_ley.dart';
import 'package:adasba_2024/presentation/providers/compromisos_ley/compromisos_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';

part 'compromisos_ley_manager.g.dart';

@riverpod
class CompromisosLeyManager extends _$CompromisosLeyManager {
  @override
  Future<List<CompromisoLey>> build() async {
    final storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<CompromisoLey> listado = [];
    final result =
        await ref.watch(getAllCompromisosProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(compromisosLeyManagerProvider.future);
  }
}
