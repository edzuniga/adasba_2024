import 'package:flutter/material.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class IndicadoresTableSource extends DataTableSource {
  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 200;

  @override
  int get selectedRowCount => 0;

  //DATOS SERIALIZADOS QUE VIENEN DE LA BD
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.verdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'I.1.R.1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: const Text(
                'Nombre completo del indicador irá en este campo)',
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: const Text(
                'Descripción completa del indicador (esto seguramente será una especie de textarea con mucho texto)',
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: const Text(
                'Componente al cual estará asociado',
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
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
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
