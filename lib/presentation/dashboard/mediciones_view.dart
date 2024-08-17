import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/constants/table_styles.dart';
import 'package:adasba_2024/presentation/dashboard/data_table_sources/mediciones_table_source.dart';

class MedicionesView extends StatefulWidget {
  const MedicionesView({super.key});

  @override
  State<MedicionesView> createState() => _MedicionesViewState();
}

class _MedicionesViewState extends State<MedicionesView> {
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
                'Gestión de Mediciones',
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
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rojoPrincipal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: const Text(
                        'Agregar medición',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        '#',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Fecha',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Realizada\npor',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Proyecto',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Plan',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Archivo',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Acción',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                  ],
                  source: MedicionesTableSource(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
