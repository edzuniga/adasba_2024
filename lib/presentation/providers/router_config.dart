import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/presentation/dashboard/configuracion/export_configuracion_views.dart';
import 'package:adasba_2024/presentation/auth/export_auth.dart';
import 'package:adasba_2024/presentation/config/routes.dart';
import 'package:adasba_2024/presentation/dashboard/export_dashboard.dart';
import 'package:adasba_2024/presentation/providers/dashboard/page_index.dart';
part 'router_config.g.dart';

@Riverpod(keepAlive: true)
GoRouter routerConfig(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      //AUTH ROUTES
      ShellRoute(
        builder: (context, state, child) => AuthLayout(child: child),
        routes: [
          GoRoute(
            name: Routes.login,
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const LoginView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.recovery,
            path: '/recovery',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const RecoveryView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
      //DASHBOARD ROUTES
      ShellRoute(
        builder: (context, state, child) => DashboardLayout(child: child),
        routes: [
          GoRoute(
            name: Routes.inicio,
            path: '/inicio',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const InicioView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.planes,
            path: '/planes',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const PlanesView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.mediciones,
            path: '/mediciones',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const MedicionesView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.central,
            path: '/central',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const CentralView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),

          //Rutas de CONFIGURACIÓN
          GoRoute(
            name: Routes.usuarios,
            path: '/usuarios',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const UsuariosView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.proyectos,
            path: '/proyectos',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const ProyectosView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.componentes,
            path: '/componentes',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const ComponentesView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.indicadores,
            path: '/indicadores',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const IndicadoresView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.compromisos,
            path: '/compromisos',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const CompromisosView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.actores,
            path: '/actores',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const ActoresView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.beneficiarios,
            path: '/beneficiarios',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const BeneficiariosView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.fuentesFinanciamiento,
            path: '/fuentes_financiamiento',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const FuentesFinanciamientoView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.gestionDocumental,
            path: '/gestion_documental',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const GestionDocumentalView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: Routes.tutoriales,
            path: '/tutoriales',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const TutorialesView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      List<String> paginasDashboard = [
        '/inicio',
        '/planes',
        '/mediciones',
        '/central',
        '/usuarios',
        '/proyectos',
        '/componentes',
        '/indicadores',
        '/compromisos',
        '/actores',
        '/beneficiarios',
        '/fuentes_financiamiento',
        '/gestion_documental',
        '/tutoriales',
      ];

      WidgetsBinding.instance.addPostFrameCallback((v) {
        final pageIndexManager = ref.read(pageIndexProvider.notifier);
        if (paginasDashboard.contains(state.matchedLocation)) {
          switch (state.matchedLocation) {
            case '/inicio':
              pageIndexManager.changePageIndex(0);
              break;
            case '/planes':
              pageIndexManager.changePageIndex(1);
              break;
            case '/mediciones':
              pageIndexManager.changePageIndex(2);
              break;
            case '/central':
              pageIndexManager.changePageIndex(3);
              break;
            case '/usuarios':
              pageIndexManager.changePageIndex(4);
              break;
            case '/proyectos':
              pageIndexManager.changePageIndex(5);
              break;
            case '/componentes':
              pageIndexManager.changePageIndex(6);
              break;
            case '/indicadores':
              pageIndexManager.changePageIndex(7);
              break;
            case '/compromisos':
              pageIndexManager.changePageIndex(8);
              break;
            case '/actores':
              pageIndexManager.changePageIndex(9);
              break;
            case '/beneficiarios':
              pageIndexManager.changePageIndex(10);
              break;
            case '/fuentes_financiamiento':
              pageIndexManager.changePageIndex(11);
              break;
            case '/gestion_documental':
              pageIndexManager.changePageIndex(12);
              break;
            case '/tutoriales':
              pageIndexManager.changePageIndex(13);
              break;
          }
        }
      });

      return null;
    },
  );
}
