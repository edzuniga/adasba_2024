import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:adasba_2024/presentation/dashboard/central/charts/mediciones_componentes_chart.dart';
import 'package:adasba_2024/presentation/dashboard/central/forms/filtros_mediciones_form.dart';
import 'package:adasba_2024/presentation/dashboard/central/tablas/indicadores_mediciones_tabla.dart';
import 'package:adasba_2024/presentation/dashboard/central/tablas/mediciones_componente_tabla.dart';
import 'package:adasba_2024/presentation/widgets/card_with_header.dart';

class MedicionesTableroView extends StatefulWidget {
  const MedicionesTableroView({super.key});

  @override
  State<MedicionesTableroView> createState() => _MedicionesTableroViewState();
}

class _MedicionesTableroViewState extends State<MedicionesTableroView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return screenSize.width >= 850 ? largeScreenBody() : smallScreenBody();
  }

  Widget largeScreenBody() {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(15),
              //Card de FILTROS
              Expanded(
                flex: 2,
                child: CardWithHeader(
                  titulo: 'Filtros',
                  contenido: FiltrosMedicionesForm(),
                ),
              ),
              Gap(15),
              //CARD de gráfico por componentes
              Expanded(
                flex: 3,
                child: CardWithHeader(
                  titulo:
                      'Gráfico de Mediciones Promedio por Componente (Ultimas Mediciones)',
                  contenido: MedicionesComponentesChart(),
                ),
              ),
              Gap(15),
            ],
          ),
          Gap(15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          //CARD de tabla
          Padding(
            padding: EdgeInsets.all(15),
            child: CardWithHeader(
              titulo: 'Promedio de las Mediciones por Componente',
              contenido: MedicionesComponenteTabla(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: CardWithHeader(
              titulo: 'Calificaciones de Indicadores por Mediciones',
              contenido: IndicadoresMedicionesTabla(),
            ),
          ),
          Gap(15),
        ],
      ),
    );
  }

  Widget smallScreenBody() {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: CardWithHeader(
              titulo: 'Filtros',
              contenido: FiltrosMedicionesForm(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: CardWithHeader(
              titulo:
                  'Gráfico de Mediciones Promedio por Componente (Ultimas Mediciones)',
              contenido: MedicionesComponentesChart(),
            ),
          ),

          Gap(15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          //CARD de tabla de
          Padding(
            padding: EdgeInsets.all(15),
            child: CardWithHeader(
              titulo: 'Promedio de las Mediciones por Componente',
              contenido: MedicionesComponenteTabla(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: CardWithHeader(
              titulo: 'Calificaciones de Indicadores por Mediciones',
              contenido: IndicadoresMedicionesTabla(),
            ),
          ),
          Gap(15),
        ],
      ),
    );
  }
}
