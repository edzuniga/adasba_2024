import 'package:flutter/material.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class MedicionesTableSource extends DataTableSource {
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
        const DataCell(Text('14 de Julio, 2024')),
        const DataCell(Text('Edgardo Zúniga')),
        const DataCell(Text('Proyecto FACM 2024')),
        DataCell(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.azulPrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Plan operativo 2024',
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
              'No hay archivo',
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
                tooltip: 'Ver',
                icon: const Icon(
                  Icons.visibility,
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
