import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/config/routes.dart';
import 'package:adasba_2024/presentation/widgets/custom_input.dart';

class RecoveryView extends StatefulWidget {
  const RecoveryView({super.key});

  @override
  State<RecoveryView> createState() => _RecoveryViewState();
}

class _RecoveryViewState extends State<RecoveryView> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _recoveryFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Form(
        key: _recoveryFormKey,
        child: Container(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                InkWell(
                  onTap: () {
                    context.goNamed(Routes.login);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Gap(5),
                      Icon(Icons.chevron_left),
                      Gap(8),
                      Text('Regresar')
                    ],
                  ),
                ),
                const Gap(15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: screenSize.height * 0.25,
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/recuperacion_imagen.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(15),
                Center(
                  child: Text(
                    'Recuperación de contraseña',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                const Gap(25),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                          'Ingrese el correo electrónico asociado a su cuenta; Le enviaremos un correo con el enlace para restablecer su contraseña. (De ser necesario, revise la bandeja de correo no deseado [spam])'),
                    ),
                  ),
                ),
                const Gap(15),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: CustomInputField(
                      label: 'Correo electrónico',
                      controlador: _emailController,
                      isRequired: true,
                    ),
                  ),
                ),
                const Gap(25),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_recoveryFormKey.currentState!.validate()) {}
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.rojoPrincipal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Restablecer contraseña',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
