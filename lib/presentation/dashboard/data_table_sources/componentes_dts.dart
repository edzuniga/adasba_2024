import 'package:flutter/material.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class ComponentesTableSource extends DataTableSource {
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
              'R2-Comp',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const DataCell(Text('Nombre completo del componente')),
        DataCell(
          SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 200,
                  minHeight: 50), // Establecer ancho máximo y altura mínima
              child: const Text(
                'Descripción completa del proyecto (esto seguramente será una especie de textarea con mucho texto)',
                //overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
        const DataCell(Text('Nombre del proyecto asociado')),
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.verdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Activo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
