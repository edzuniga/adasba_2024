import 'package:adasba_2024/presentation/providers/auth/auth_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/config/routes.dart';
import 'package:adasba_2024/presentation/widgets/custom_input.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool _isLoginIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: screenSize.width >= 800
          ? largeScreenBody(context, screenSize)
          : smallScreenBody(context, screenSize),
    );
  }

  Widget largeScreenBody(BuildContext context, Size screenSize) {
    return Container(
      width: screenSize.width * 0.7,
      height: screenSize.height * 0.65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width * 0.7,
              height: screenSize.height * 0.3,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/propuesta_hernan.png',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Logo y texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.3,
                        child: Image.asset('assets/images/logo_horizontal.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Bienvenido/a',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        'Sistema de Gestión de Proyectos',
                        style: GoogleFonts.roboto(
                          color: Colors.black38,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Gap(15),
                // Formulario
                Expanded(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Gap(20),
                        SizedBox(
                          width: screenSize.width * 0.3,
                          child: CustomInputField(
                            controlador: _emailController,
                            label: 'Correo electrónico',
                            isEmail: true,
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          width: screenSize.width * 0.3,
                          child: CustomInputField(
                            controlador: _passwordController,
                            label: 'Contraseña',
                            isRequired: true,
                            isPassword: true,
                          ),
                        ),
                        const Gap(40),
                        ElevatedButton(
                          onPressed: _isLoginIn
                              ? () {}
                              : () async {
                                  if (_loginFormKey.currentState!.validate()) {
                                    await _tryLogin();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.rojoPrincipal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoginIn
                              ? SpinPerfect(
                                  infinite: true,
                                  child: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Iniciar sesión',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        const Gap(8),
                        SizedBox(
                          width: 250,
                          child: OutlinedButton(
                            onPressed: () {
                              context.goNamed(Routes.recovery);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Recuperar contraseña'),
                          ),
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
                const Gap(25),
              ],
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Container smallScreenBody(BuildContext context, Size screenSize) {
    return Container(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: _loginFormKey,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenSize.width * 0.9,
                height: screenSize.height * 0.2,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/propuesta_hernan.png',
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(10),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Image.asset('assets/images/logo_horizontal.png'),
                    ),
                    const Gap(15),
                  ],
                ),
              ),
              const Gap(10),
              Text(
                'Bienvenido/a',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Gap(5),
              Text(
                'Sistema de Gestión de Proyectos',
                style: GoogleFonts.roboto(
                  color: Colors.black38,
                  fontSize: 10,
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomInputField(
                  controlador: _emailController,
                  label: 'Correo electrónico',
                  isEmail: true,
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomInputField(
                  controlador: _passwordController,
                  label: 'Contraseña',
                  isRequired: true,
                  isPassword: true,
                ),
              ),
              const Gap(20),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: _isLoginIn
                        ? () {}
                        : () async {
                            if (_loginFormKey.currentState!.validate()) {
                              await _tryLogin();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.rojoPrincipal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoginIn
                        ? SpinPerfect(
                            infinite: true,
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Iniciar sesión',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const Gap(10),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      context.goNamed(Routes.recovery);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Recuperar contraseña'),
                  ),
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _tryLogin() async {
    setState(() => _isLoginIn = true);
    await ref
        .read(authManagerProvider.notifier)
        .tryLogin(_emailController.text, _passwordController.text, context)
        .then((answer) {
      setState(() => _isLoginIn = false);
      if (answer == 'success') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Inicio de sesión exitoso',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        context.goNamed(Routes.inicio);
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              answer.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    });
  }
}
