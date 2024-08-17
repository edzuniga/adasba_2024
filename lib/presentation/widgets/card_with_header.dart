import 'package:adasba_2024/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWithHeader extends StatelessWidget {
  const CardWithHeader(
      {required this.titulo, required this.contenido, super.key});

  final Widget contenido;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(15, 15),
              blurRadius: 15,
              color: Colors.black.withOpacity(0.05),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Text(
              titulo,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: AppColors.azulPrincipal,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: contenido,
          ),
        ],
      ),
    );
  }
}
