import 'package:flutter/material.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class DocumentosTableSource extends DataTableSource {
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
        const DataCell(Text('Nombre del archivo')),
        const DataCell(Text('Descripción ejemplo')),
        const DataCell(Text('Categoría ejemplo')),
        const DataCell(Text('Fecha creado')),
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.azulPrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.verdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Privado',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.verdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Ver Archivo',
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
                tooltip: 'Versiones',
                icon: const Icon(
                  Icons.vertical_split_rounded,
                  color: AppColors.amarilloPrincipal,
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
