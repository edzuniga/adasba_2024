import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adasba_2024/domain/entities/fuente.dart';
import 'package:adasba_2024/presentation/dashboard/modales/fuentes_modal.dart';
import 'package:adasba_2024/presentation/providers/fuentes/fuentes_manager.dart';
import 'package:adasba_2024/presentation/providers/proyectos/proyectos_repository_provider.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/constants/app_colors.dart';

class FuentesFinanciamientoTableSource extends DataTableSource {
  FuentesFinanciamientoTableSource(
      {required this.data, required this.ref, required this.context});
  final List<Fuente> data;
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
    Fuente fuente = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}')),
        //Nombre del proyecto
        DataCell(
          FutureBuilder(
            future: _getProyectoNombre(fuente.idProyecto),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Error: No se pudo obtener el proyecto!!',
                    style: TextStyle(
                      color: AppColors.rojoPrincipal,
                    ),
                  ),
                );
              }

              String nombreProyecto = snapshot.data!;
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.verdePrincipal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  nombreProyecto,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
        //Código de la fuente
        DataCell(Text(fuente.codigoFuente)),
        //Nombre de la fuente
        DataCell(Text(fuente.nombreFuente)),
        //Descripción de la fuente
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                fuente.descripcionFuente.toString(),
                //overflow: TextOverflow.ellipsis,
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
                  await _deleteFuenteModal(fuente);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await _updateFuenteModal(fuente);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateFuenteModal(Fuente fuente) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: FuentesModal(
          titulo: 'Editar',
          modalPurpose: ModalPurpose.update,
          fuente: fuente,
        ),
      ),
    );

    if (res) {
      ref.read(fuentesManagerProvider.notifier).refresh();
    }
  }

  Future<void> _deleteFuenteModal(Fuente fuente) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: FuentesModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          fuente: fuente,
        ),
      ),
    );

    if (res) {
      ref.read(fuentesManagerProvider.notifier).refresh();
    }
  }

  Future<String> _getProyectoNombre(int id) async {
    String nombreProyecto = '';
    final response = await ref.read(getSpecificProyectoProvider).call(id);
    response.fold((failure) {
      throw const ServerFailure(message: 'Ocurrió un error');
    }, (proyecto) {
      nombreProyecto = proyecto.nombreCorto;
    });
    return nombreProyecto;
  }
}
