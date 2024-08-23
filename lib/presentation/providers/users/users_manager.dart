import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/presentation/providers/users/users_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/domain/entities/user.dart';
part 'users_manager.g.dart';

@riverpod
class UsuariosManager extends _$UsuariosManager {
  @override
  Future<List<User>> build() async {
    final storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<User> listado = [];
    final result =
        await ref.watch(getAllUsersProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(usuariosManagerProvider.future);
  }
}
