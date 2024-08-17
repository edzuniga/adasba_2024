import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:adasba_2024/presentation/config/routes.dart';
import 'package:adasba_2024/presentation/widgets/simple_card_widget.dart';
import 'package:adasba_2024/constants/app_colors.dart';

class LargeInicioBody extends StatelessWidget {
  const LargeInicioBody({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          //Large Card
          Container(
            padding: const EdgeInsets.all(8),
            width: screenSize.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF0FB),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 0),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: screenSize.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tableros',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.azulPrincipal,
                        ),
                      ),
                      Text(
                        'Bienvenid@s al sistema de gestión total de ADASBA',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(20),
                Center(
                  child: Lottie.asset('assets/lotties/coworking_2.json',
                      height: screenSize.height * 0.35, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
          const Gap(20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            //Row de custom simple card widgets
            child: Row(
              children: [
                Expanded(
                  child: SimpleCustomCard(
                    iconito: Icons.checklist,
                    titulo: 'Indicadores',
                    cantidad: 25,
                    iconColor: AppColors.azulPrincipal,
                    ruta: Routes.indicadores,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: SimpleCustomCard(
                    iconito: Icons.poll_outlined,
                    titulo: 'Mediciones',
                    cantidad: 80,
                    iconColor: AppColors.rojoPrincipal,
                    ruta: Routes.mediciones,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: SimpleCustomCard(
                    iconito: Icons.edit_square,
                    titulo: 'Planes',
                    cantidad: 15,
                    iconColor: AppColors.amarilloPrincipal,
                    ruta: Routes.planes,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: SimpleCustomCard(
                    iconito: Icons.list_alt,
                    titulo: 'Proyectos',
                    cantidad: 5,
                    iconColor: AppColors.verdePrincipal,
                    ruta: Routes.proyectos,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: SimpleCustomCard(
                    iconito: Icons.layers,
                    titulo: 'Componentes',
                    cantidad: 14,
                    iconColor: AppColors.moradoSecundario,
                    ruta: Routes.componentes,
                  ),
                ),
              ],
            ),
          ),

          const Gap(20),
        ],
      ),
    );
  }
}
