import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/constants/table_styles.dart';
import 'package:adasba_2024/presentation/dashboard/data_table_sources/planes_table_source.dart';

class PlanesView extends StatefulWidget {
  const PlanesView({super.key});

  @override
  State<PlanesView> createState() => _PlanesViewState();
}

class _PlanesViewState extends State<PlanesView> {
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
                'Gestión de Planes',
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
                        'Agregar plan',
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
                        'Realizada\npor',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Responsable',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Versión',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Estado',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actividades',
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
                  source: PlanesTableSource(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
