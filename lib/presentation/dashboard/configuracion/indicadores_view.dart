import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/presentation/dashboard/data_table_sources/indicadores_dts.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/constants/table_styles.dart';

class IndicadoresView extends StatefulWidget {
  const IndicadoresView({super.key});

  @override
  State<IndicadoresView> createState() => _IndicadoresViewState();
}

class _IndicadoresViewState extends State<IndicadoresView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(20),
            Center(
              child: Text(
                'Tabla de Indicadores',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  headingRowColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    return AppColors.azulPrincipal.withOpacity(0.05);
                  }),
                  showFirstLastButtons: true,
                  header: const SizedBox(),
                  actions: [
                    ElevatedButton(
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
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Agregar',
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.rojoPrincipal,
                      ),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  columns: <DataColumn>[
                    DataColumn(
                      numeric: true,
                      label: Text(
                        '#',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Número',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Indicador',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Descripción',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Componente',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Acciones',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                  ],
                  source: IndicadoresTableSource(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
