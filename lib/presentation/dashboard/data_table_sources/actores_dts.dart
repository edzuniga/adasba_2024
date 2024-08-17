import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adasba_2024/presentation/dashboard/modales/actores_modal.dart';
import 'package:adasba_2024/presentation/providers/actores/actores_manager.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/domain/entities/actor.dart';
import 'package:adasba_2024/constants/app_colors.dart';

class ActoresTableSource extends DataTableSource {
  ActoresTableSource(
      {required this.data, required this.ref, required this.context});
  final List<Actor> data;
  final WidgetRef ref;
  final BuildContext context;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  //DATOS SERIALIZADOS QUE VIENEN DE LA BD
  @override
  DataRow? getRow(int index) {
    Actor actor = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data.length - index}')),
        //Nombre
        DataCell(Text(actor.nombre)),
        //Descripción
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                actor.descripcion,
                softWrap: true,
              ),
            ),
          ),
        ),
        //Acciones
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Borrar',
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: AppColors.rojoPrincipal,
                ),
                onPressed: () async {
                  await _deleteActoresModal(actor);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await _updateActoresModal(actor);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateActoresModal(Actor actor) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: ActoresModal(
          titulo: 'Editar',
          modalPurpose: ModalPurpose.update,
          actor: actor,
        ),
      ),
    );

    if (res) {
      ref.read(actoresManagerProvider.notifier).refresh();
    }
  }

  Future<void> _deleteActoresModal(Actor actor) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: ActoresModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          actor: actor,
        ),
      ),
    );

    if (res) {
      ref.read(actoresManagerProvider.notifier).refresh();
    }
  }
}
