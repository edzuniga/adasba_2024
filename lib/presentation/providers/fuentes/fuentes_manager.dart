import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/domain/entities/fuente.dart';
import 'package:adasba_2024/presentation/providers/fuentes/fuentes_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';

part 'fuentes_manager.g.dart';

@riverpod
class FuentesManager extends _$FuentesManager {
  @override
  Future<List<Fuente>> build() async {
    final storage = SecureStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<Fuente> listado = [];
    final result =
        await ref.watch(getAllFuentesProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(fuentesManagerProvider.future);
  }
}
