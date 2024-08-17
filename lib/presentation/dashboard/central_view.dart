import 'package:adasba_2024/presentation/dashboard/central/power_bi_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:adasba_2024/presentation/dashboard/central/planes_tablero_view.dart';
import 'package:adasba_2024/presentation/dashboard/central/seguimiento_actividades_tablero_view.dart';
import 'package:adasba_2024/presentation/dashboard/central/mediciones_tablero_view.dart';
import 'package:adasba_2024/constants/app_colors.dart';

class CentralView extends StatefulWidget {
  const CentralView({super.key});

  @override
  State<CentralView> createState() => _CentralViewState();
}

class _CentralViewState extends State<CentralView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: screenSize.height * 0.9,
        constraints: const BoxConstraints(
          maxWidth: 1700,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 15,
                color: Colors.black.withOpacity(0.1),
              )
            ]),
        child: const DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                indicatorColor: AppColors.azulPrincipal,
                tabs: [
                  Tab(
                    icon: Icon(Icons.dashboard),
                    text: 'Dashboard mediciones',
                  ),
                  Tab(
                    icon: Icon(Icons.dashboard),
                    text: 'Dashboard planes',
                  ),
                  Tab(
                    icon: Icon(Icons.dashboard),
                    text: 'Seguimiento de actividades',
                  ),
                  Tab(
                    icon: Icon(Icons.insert_chart_outlined_outlined),
                    text: 'Power BI',
                  ),
                ],
              ),
              Gap(10),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    MedicionesTableroView(),
                    PlanesTableroView(),
                    SeguimientoActividadesTableroView(),
                    PowerBiView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
