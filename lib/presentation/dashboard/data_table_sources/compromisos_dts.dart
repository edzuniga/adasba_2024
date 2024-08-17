import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adasba_2024/domain/entities/compromiso_ley.dart';
import 'package:adasba_2024/presentation/dashboard/modales/compromisos_modal.dart';
import 'package:adasba_2024/presentation/providers/compromisos_ley/compromisos_ley_manager.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';

class CompromisosTableSource extends DataTableSource {
  CompromisosTableSource(
      {required this.data, required this.ref, required this.context});
  final List<CompromisoLey> data;
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
    CompromisoLey compromiso = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data.length - index}')),
        //Nombre
        DataCell(Text(compromiso.nombre)),
        //Descripción
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                compromiso.descripcion,
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
                  await _deleteCompromisoModal(compromiso);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await _updateCompromisoModal(compromiso);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateCompromisoModal(CompromisoLey compromiso) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: CompromisosModal(
          titulo: 'Editar',
          modalPurpose: ModalPurpose.update,
          compromiso: compromiso,
        ),
      ),
    );

    if (res) {
      ref.read(compromisosLeyManagerProvider.notifier).refresh();
    }
  }

  Future<void> _deleteCompromisoModal(CompromisoLey compromiso) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: CompromisosModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          compromiso: compromiso,
        ),
      ),
    );

    if (res) {
      ref.read(compromisosLeyManagerProvider.notifier).refresh();
    }
  }
}
