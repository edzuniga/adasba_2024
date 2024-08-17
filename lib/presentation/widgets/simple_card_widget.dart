import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleCustomCard extends StatelessWidget {
  const SimpleCustomCard({
    super.key,
    required this.iconito,
    required this.titulo,
    required this.cantidad,
    required this.iconColor,
    required this.ruta,
  });

  final IconData iconito;
  final String titulo;
  final int cantidad;
  final Color iconColor;
  final String ruta;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(ruta);
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(5, 5),
                blurRadius: 10,
                spreadRadius: 0),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    iconito,
                    size: 30,
                    color: iconColor,
                  ),
                  Text(
                    titulo,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '$cantidad',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            //Ribbon
            Positioned(
              right: 20,
              top: 0,
              child: Container(
                width: 15,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: iconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
