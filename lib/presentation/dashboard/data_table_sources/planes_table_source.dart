import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class PlanesTableSource extends DataTableSource {
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
        const DataCell(Text('Proyecto FACM 2024')),
        const DataCell(Text('Plan operativo 2024')),
        const DataCell(Text('Pedro González')),
        const DataCell(Text('Edgardo Zúniga')),
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
              'Activo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        DataCell(
          Column(
            children: [
              const Text('15 / 20'),
              const Gap(5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.verdePrincipal,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Presupuesto',
                icon: const Icon(
                  Icons.monetization_on,
                  color: AppColors.rojoPrincipal,
                ),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Actividades',
                icon: const Icon(
                  Icons.checklist,
                  color: AppColors.verdePrincipal,
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
              IconButton(
                tooltip: 'Versiones',
                icon: const Icon(
                  Icons.vertical_split_rounded,
                  color: AppColors.amarilloPrincipal,
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
