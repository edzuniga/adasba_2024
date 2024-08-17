import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class MedicionesComponenteTabla extends StatefulWidget {
  const MedicionesComponenteTabla({super.key});

  @override
  State<MedicionesComponenteTabla> createState() =>
      _MedicionesComponenteTablaState();
}

class _MedicionesComponenteTablaState extends State<MedicionesComponenteTabla> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amarilloPrincipal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: const Text(
              'Exportar tabla',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Gap(10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(
              width: 0.5,
              color: Colors.black38,
            ),
            headingTextStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
            ),
            headingRowColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              return AppColors.azulPrincipal.withOpacity(0.05);
            }),
            columns: const <DataColumn>[
              DataColumn(
                label: SizedBox(width: 50, child: Text('Ver')),
              ),
              DataColumn(
                label: SizedBox(width: 200, child: Text('Proyecto')),
              ),
              DataColumn(
                label: SizedBox(width: 100, child: Text('Fecha')),
              ),
              DataColumn(
                label: SizedBox(width: 150, child: Text('Tipo de medición')),
              ),
              DataColumn(
                label: SizedBox(width: 50, child: Text('R1')),
              ),
              DataColumn(
                label: SizedBox(width: 50, child: Text('R2')),
              ),
              DataColumn(
                label: SizedBox(width: 50, child: Text('R3')),
              ),
              DataColumn(
                label:
                    SizedBox(width: 200, child: Text('Promedio del Proyecto')),
              ),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Ver'),
                    ),
                  ),
                  const DataCell(
                    SizedBox(
                        child: Text(
                            'Nombre muy largo del proyecto, asdfasdfasdfasdfasdfasdf')),
                  ),
                  const DataCell(
                    Text('2024-10-11'),
                  ),
                  const DataCell(
                    Text('Parcial'),
                  ),
                  const DataCell(
                    Text('1.4'),
                  ),
                  const DataCell(
                    Text('2.4'),
                  ),
                  const DataCell(
                    Text('3.4'),
                  ),
                  DataCell(
                    Text(
                      '2.1',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
