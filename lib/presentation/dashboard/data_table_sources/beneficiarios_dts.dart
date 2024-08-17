import 'package:flutter/material.dart';

import 'package:adasba_2024/domain/entities/grupo_beneficiario.dart';
import 'package:adasba_2024/presentation/dashboard/modales/grupos_modal.dart';
import 'package:adasba_2024/presentation/providers/grupos/grupos_manager.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeneficiariosTableSource extends DataTableSource {
  BeneficiariosTableSource(
      {required this.data, required this.ref, required this.context});
  final List<Grupo> data;
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
    Grupo grupo = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        //Índice
        DataCell(Text('${data.length - index}')),
        //Nombre del grupo
        DataCell(Text(grupo.nombre)),
        //Descripción del grupo
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                '${grupo.descripcion}',
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
                  await _deleteGrupoModal(grupo);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await _updateGrupoModal(grupo);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateGrupoModal(Grupo grupo) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: GrupoModal(
          titulo: 'Editar',
          modalPurpose: ModalPurpose.update,
          grupo: grupo,
        ),
      ),
    );

    if (res) {
      ref.read(gruposManagerProvider.notifier).refresh();
    }
  }

  Future<void> _deleteGrupoModal(Grupo grupo) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: GrupoModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          grupo: grupo,
        ),
      ),
    );

    if (res) {
      ref.read(gruposManagerProvider.notifier).refresh();
    }
  }
}
