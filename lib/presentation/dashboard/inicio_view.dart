import 'package:adasba_2024/presentation/dashboard/large_screens/large_inicio_body.dart';
import 'package:flutter/material.dart';

import 'package:adasba_2024/presentation/dashboard/small_screens/small_inicio_body.dart';

class InicioView extends StatefulWidget {
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: screenSize.width < 901
          ? SmallInicioBody(screenSize: screenSize)
          : LargeInicioBody(screenSize: screenSize),
    );
  }
}
