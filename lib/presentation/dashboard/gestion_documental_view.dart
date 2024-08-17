import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/presentation/dashboard/data_table_sources/documentos_table_source.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/constants/table_styles.dart';

class GestionDocumentalView extends StatefulWidget {
  const GestionDocumentalView({super.key});

  @override
  State<GestionDocumentalView> createState() => _GestionDocumentalViewState();
}

class _GestionDocumentalViewState extends State<GestionDocumentalView> {
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
                'Gestión Documental',
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
                        'Agregar archivo',
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
                        'Nombre',
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
                        'Categoría',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Fecha\ncreado',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Última\nversión',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tipo',
                        style: CustomTableStyle.estiloTitulos,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Último\narchivo',
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
                  source: DocumentosTableSource(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
