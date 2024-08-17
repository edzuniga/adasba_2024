import 'package:adasba_2024/domain/entities/proyecto.dart';
import 'package:adasba_2024/presentation/dashboard/modales/proyectos_modal.dart';
import 'package:adasba_2024/presentation/providers/grupos/grupos_repository_provider.dart';
import 'package:adasba_2024/presentation/providers/proyectos/proyectos_manager.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:flutter/material.dart';

import 'package:adasba_2024/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProyectosTableSource extends DataTableSource {
  ProyectosTableSource(
      {required this.data, required this.ref, required this.context});
  final List<Proyecto> data;
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
    Proyecto proyecto = data[index];
    //Create array from usuario.gruposBeneficiarios
    List<int> listGruposBeneficiariosId =
        proyecto.gruposRelacionados.split(',').map(int.parse).toList();
    // Formatear la fecha en español
    String formattedDate = DateFormat.yMMMMd('es').format(proyecto.fechaCreado);

    return DataRow.byIndex(
      index: index,
      cells: [
        //Índice decreciendo
        DataCell(Text('${data.length - index}')),
        //Nombre completo
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                proyecto.nombreProyecto,
                softWrap: true,
              ),
            ),
          ),
        ),
        //nombre corto
        DataCell(Text(proyecto.nombreCorto)),
        //Descripción
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                proyecto.descripcion,
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        //Fecha creado
        DataCell(Text(formattedDate)),
        //Grupos beneficiarios
        DataCell(
          FutureBuilder(
              future: _getGruposNombres(listGruposBeneficiariosId, ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Error: No se pudieron obtener los grupos!!',
                      style: TextStyle(
                        color: AppColors.rojoPrincipal,
                      ),
                    ),
                  );
                }

                String nombresDeGrupos = snapshot.data!;
                return SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 200,
                      minHeight: 50, // Establecer ancho máximo y altura mínima
                    ),
                    child: Text(
                      nombresDeGrupos,
                      softWrap: true,
                    ),
                  ),
                );
              }),
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
                  await _deleteProyectoModal(proyecto);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await _updateProyectoModal(proyecto);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateProyectoModal(Proyecto proyecto) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: ProyectoModal(
          titulo: 'Editar',
          modalPurpose: ModalPurpose.update,
          proyecto: proyecto,
        ),
      ),
    );

    if (res) {
      ref.read(proyectosManagerProvider.notifier).refresh();
    }
  }

  Future<void> _deleteProyectoModal(Proyecto proyecto) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: ProyectoModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          proyecto: proyecto,
        ),
      ),
    );

    if (res) {
      ref.read(proyectosManagerProvider.notifier).refresh();
    }
  }
}

// Función auxiliar para obtener los nombres de los grupos beneficiarios
Future<String> _getGruposNombres(List<int> grupoIds, WidgetRef ref) async {
  String nombreGrupos = '';
  for (var id in grupoIds) {
    final response = await ref.read(getSpecificGrupoProvider).call(id);
    response.fold((failure) {
      throw const ServerFailure(message: 'Ocurrió un error');
    }, (grupo) {
      nombreGrupos += '${grupo.nombre}, ';
    });
  }
  nombreGrupos = nombreGrupos.trimRight();
  if (nombreGrupos.endsWith(',')) {
    nombreGrupos = nombreGrupos.substring(0, nombreGrupos.length - 1);
  }
  return nombreGrupos;
}
