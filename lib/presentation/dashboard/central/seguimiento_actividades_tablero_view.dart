import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:adasba_2024/presentation/widgets/card_with_header.dart';

class SeguimientoActividadesTableroView extends StatefulWidget {
  const SeguimientoActividadesTableroView({super.key});

  @override
  State<SeguimientoActividadesTableroView> createState() =>
      _SeguimientoActividadesTableroViewState();
}

class _SeguimientoActividadesTableroViewState
    extends State<SeguimientoActividadesTableroView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: CardWithHeader(
                titulo: 'Filtros',
                contenido: Text('algo'),
              ),
            ),
            Gap(15),
            Expanded(
              child: CardWithHeader(
                titulo:
                    'Gráfico de Mediciones Promedio por Componente (Ultimas Mediciones)',
                contenido: Text('algo'),
              ),
            ),
          ],
        ),
        Gap(30),
        CardWithHeader(
          titulo: 'Promedio de las Mediciones por Componente',
          contenido: Text('algo'),
        ),
      ],
    );
  }
}
