import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/domain/entities/proyecto.dart';
import 'package:adasba_2024/presentation/providers/proyectos/proyectos_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';

part 'proyectos_manager.g.dart';

@riverpod
class ProyectosManager extends _$ProyectosManager {
  @override
  Future<List<Proyecto>> build() async {
    final storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    List<Proyecto> listado = [];
    final result =
        await ref.watch(getAllProyectosProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(message: 'Error de conexión');
    }, (listadoSuccess) {
      listado = listadoSuccess;
    });
    return listado;
  }

  //Función para refrescar el provider (listado)
  Future<void> refresh() {
    return ref.refresh(proyectosManagerProvider.future);
  }
}
