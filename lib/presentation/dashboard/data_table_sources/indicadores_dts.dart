import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adasba_2024/domain/entities/indicador.dart';
import 'package:adasba_2024/presentation/dashboard/modales/indicadores_modal.dart';
import 'package:adasba_2024/presentation/providers/componentes/componentes_repository_provider.dart';
import 'package:adasba_2024/presentation/providers/indicadores/indicadores_manager.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/constants/app_colors.dart';

class IndicadoresTableSource extends DataTableSource {
  IndicadoresTableSource(
      {required this.data, required this.ref, required this.context});
  final List<Indicador> data;
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
    Indicador indicador = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}')),
        //Número de Indicador
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.verdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              indicador.numeroIndicador,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        //Nombre corto del indicador
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                indicador.nombreCortoIndicador,
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        //Descripción del indicador
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: Text(
                indicador.descripcionIndicador.toString(),
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        DataCell(
          FutureBuilder(
            future: _getComponenteNombre(indicador.componenteRelacionado),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Error: No se pudo obtener el componente!!',
                    style: TextStyle(
                      color: AppColors.rojoPrincipal,
                    ),
                  ),
                );
              }

              String nombreComponente = snapshot.data!;
              return SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(
                      maxWidth: 200,
                      minHeight: 50), // Establecer ancho máximo y altura mínima
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    nombreComponente,
                    softWrap: true,
                  ),
                ),
              );
            },
          ),
        ),
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
                  await _deleteIndicadorModal(indicador);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await _updateIndicadorModal(indicador);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _updateIndicadorModal(Indicador indicador) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: IndicadoresModal(
          titulo: 'Editar',
          modalPurpose: ModalPurpose.update,
          indicador: indicador,
        ),
      ),
    );

    if (res) {
      ref.read(indicadoresManagerProvider.notifier).refresh();
    }
  }

  Future<void> _deleteIndicadorModal(Indicador indicador) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: IndicadoresModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          indicador: indicador,
        ),
      ),
    );

    if (res) {
      ref.read(indicadoresManagerProvider.notifier).refresh();
    }
  }

  Future<String> _getComponenteNombre(int id) async {
    String nombreComponente = '';
    final response = await ref.read(getSpecificComponenteProvider).call(id);
    response.fold((failure) {
      throw const ServerFailure(message: 'Ocurrió un error');
    }, (componente) {
      nombreComponente = componente.nombreComponente;
    });
    return nombreComponente;
  }
}
