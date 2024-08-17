import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/presentation/providers/grupos/grupos_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';
import 'package:adasba_2024/domain/entities/grupo_beneficiario.dart';

part 'grupos_manager.g.dart';

@riverpod
class GruposManager extends _$GruposManager {
  @override
  Future<List<Grupo>> build() async {
    final storage = SecureStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<Grupo> listado = [];
    final result =
        await ref.watch(getAllGruposProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(gruposManagerProvider.future);
  }
}
