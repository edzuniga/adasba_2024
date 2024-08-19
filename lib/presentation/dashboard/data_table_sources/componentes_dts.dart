import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adasba_2024/presentation/dashboard/modales/componentes_modal.dart';
import 'package:adasba_2024/presentation/providers/componentes/componentes_manager.dart';
import 'package:adasba_2024/presentation/providers/proyectos/proyectos_repository_provider.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/domain/entities/componente.dart';

class ComponentesTableSource extends DataTableSource {
  ComponentesTableSource(
      {required this.data, required this.ref, required this.context});
  final List<Componente> data;
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
    Componente componente = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}')),
        //Código del componente
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.verdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              componente.codigoComponente,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        //Nombre del componente
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                componente.nombreComponente,
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        //Descripción del componente
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                componente.descripcionComponente.toString(),
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        //Proyecto asociado
        DataCell(
          FutureBuilder(
            future: _getProyectoNombre(componente.idProyecto),
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
                  color: AppColors.amarilloPrincipal,
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
                  await _deleteComponenteModal(componente);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await _updateComponenteModal(componente);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateComponenteModal(Componente componente) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: ComponentesModal(
          titulo: 'Editar',
          modalPurpose: ModalPurpose.update,
          componente: componente,
        ),
      ),
    );

    if (res) {
      ref.read(componentesManagerProvider.notifier).refresh();
    }
  }

  Future<void> _deleteComponenteModal(Componente componente) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: ComponentesModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          componente: componente,
        ),
      ),
    );

    if (res) {
      ref.read(componentesManagerProvider.notifier).refresh();
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
