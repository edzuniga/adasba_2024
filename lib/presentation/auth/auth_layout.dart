import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/presentation/config/routes.dart';
import 'package:adasba_2024/presentation/providers/auth/auth_manager.dart';

class AuthLayout extends ConsumerStatefulWidget {
  const AuthLayout({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends ConsumerState<AuthLayout> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    //Revisar si hay datos almacenados en el storage
    LocalStorage storage = LocalStorage();
    Map<String, String> credencialesEnStorage = await storage.getAllValues();

    //Cuando hay datos en el storage
    if (credencialesEnStorage.isNotEmpty) {
      String? accessTokenExpiryDate = await storage.getAccessTokenExpiryDate();
      DateTime fechaVencimientoAccessToken =
          DateTime.parse(accessTokenExpiryDate!);
      DateTime now = DateTime.now();

      //Se intenta renovar el access token, solamente si se encuentra vencido
      WidgetsBinding.instance.addPostFrameCallback((value) {
        if (fechaVencimientoAccessToken.isBefore(now)) {
          //* INTENTAR RENOVAR EL TOKEN
          ref
              .read(authManagerProvider.notifier)
              .tryRefreshToken()
              .then((value) {
            if (value == 'success') {
              context.goNamed(Routes.inicio);
            }
          });
        } else {
          context.goNamed(Routes.inicio);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFF1777A9),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/efecto_bg.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: widget.child,
      ),
    );
  }
}
