import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/presentation/providers/auth/credentials_manager.dart';
import 'package:adasba_2024/presentation/providers/auth/auth_manager.dart';
import 'package:adasba_2024/presentation/providers/dashboard/page_title.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/config/routes.dart';
import 'package:adasba_2024/presentation/providers/dashboard/page_index.dart';

class DashboardLayout extends ConsumerStatefulWidget {
  const DashboardLayout({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends ConsumerState<DashboardLayout> {
  int pageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<int> _configuracionPageIndexes = [4, 5, 6, 7, 8, 9, 10, 11];
  String? _nombres;
  String? _apellidos;
  String? _correo;
  bool _isLoginOut = false;

  void navigateTo(BuildContext context, int pageIndex, String pagina) {
    ref.read(pageIndexProvider.notifier).changePageIndex(pageIndex);
    _scaffoldKey.currentState!.closeDrawer();
    context.goNamed(pagina);
  }

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
      //Insertar los valores en el provider de userCredentials
      ref
          .read(userCredentialsProvider.notifier)
          .setUserCredentials(credencialesEnStorage);
      String? accessTokenExpiryDate = await storage.getAccessTokenExpiryDate();
      String? storageNombres = await storage.getNombres();
      String? storageApellidos = await storage.getApellidos();
      String? storageCorreo = await storage.getCorreo();

      setState(() {
        _nombres = storageNombres ?? '';
        _apellidos = storageApellidos ?? '';
        _correo = storageCorreo ?? '';
      });

      DateTime fechaVencimientoAccessToken =
          DateTime.parse(accessTokenExpiryDate!);
      DateTime now = DateTime.now();

      //Se intenta renovar el access token, solamente si se encuentra vencido
      //* INTENTAR RENOVAR EL TOKEN
      WidgetsBinding.instance.addPostFrameCallback((value) {
        if (fechaVencimientoAccessToken.isBefore(now)) {
          ref
              .read(authManagerProvider.notifier)
              .tryRefreshToken()
              .then((value) {
            if (value != 'success') {
              //Realizar el logout FORZADO
              ref
                  .read(authManagerProvider.notifier)
                  .tryLogout()
                  .then((message) {
                //Navegar al auth para que realice el login nuevamente
                context.goNamed(Routes.login);
              });
            }
          });
        }
      });
    } else {
      if (!mounted) return;
      context.goNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    int pageIndex = ref.watch(pageIndexProvider);
    String pageTitle = ref.watch(pageTitleProvider);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.azulPrincipal,
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia el color del icono del drawer
        ),
        title: Text(
          pageTitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _isLoginOut
                ? () {}
                : () async {
                    await _tryLogout();
                  },
            tooltip: 'Cerrar sesión',
            icon: _isLoginOut
                ? SpinPerfect(
                    infinite: true,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      drawer: menuLateralPrincipal(pageIndex, context),
      body: widget.child,
    );
  }

  //Menú lateral principal del dashboard (cuando ya hay login)
  Drawer menuLateralPrincipal(int pageIndex, BuildContext context) {
    String nombreCompleto =
        _nombres != null && _apellidos != null ? '$_nombres $_apellidos' : '';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.azulPrincipal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.azulPrincipal,
                    ),
                  ),
                  const Gap(15),
                  Text(
                    nombreCompleto,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _correo ?? '',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                  ),
                ],
              )),
          const Gap(25),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Menú',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: AppColors.azulPrincipal,
              ),
            ),
          ),
          const Gap(15),
          Container(
            color: pageIndex == 0
                ? AppColors.azulPrincipal.withOpacity(0.05)
                : null,
            child: ListTile(
              leading: pageIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              title: const Text('Inicio'),
              textColor: pageIndex == 0 ? AppColors.azulPrincipal : null,
              iconColor: pageIndex == 0 ? AppColors.azulPrincipal : null,
              onTap: () => navigateTo(context, 0, Routes.inicio),
            ),
          ),
          Container(
            color: pageIndex == 1
                ? AppColors.azulPrincipal.withOpacity(0.05)
                : null,
            child: ListTile(
              leading: pageIndex == 1
                  ? const Icon(Icons.checklist_rtl)
                  : const Icon(Icons.checklist_rtl),
              title: const Text('Planes'),
              textColor: pageIndex == 1 ? AppColors.azulPrincipal : null,
              iconColor: pageIndex == 1 ? AppColors.azulPrincipal : null,
              onTap: () => navigateTo(context, 1, Routes.planes),
            ),
          ),
          Container(
            color: pageIndex == 2
                ? AppColors.azulPrincipal.withOpacity(0.05)
                : null,
            child: ListTile(
              leading: pageIndex == 2
                  ? const Icon(Icons.monitor_heart)
                  : const Icon(Icons.monitor_heart_outlined),
              title: const Text('Mediciones'),
              textColor: pageIndex == 2 ? AppColors.azulPrincipal : null,
              iconColor: pageIndex == 2 ? AppColors.azulPrincipal : null,
              onTap: () => navigateTo(context, 2, Routes.mediciones),
            ),
          ),
          Container(
            color: pageIndex == 3
                ? AppColors.azulPrincipal.withOpacity(0.05)
                : null,
            child: ListTile(
              leading: pageIndex == 3
                  ? const Icon(Icons.public)
                  : const Icon(Icons.language),
              title: const Text('Central de Información'),
              textColor: pageIndex == 3 ? AppColors.azulPrincipal : null,
              iconColor: pageIndex == 3 ? AppColors.azulPrincipal : null,
              onTap: () => navigateTo(context, 3, Routes.central),
            ),
          ),
          Container(
            color: _configuracionPageIndexes.contains(pageIndex)
                ? AppColors.azulPrincipal.withOpacity(0.05)
                : null,
            child: ExpansionTile(
              shape: const RoundedRectangleBorder(),
              expansionAnimationStyle: AnimationStyle(
                  curve: Curves.easeInOut,
                  duration: const Duration(
                    milliseconds: 400,
                  )),
              leading: _configuracionPageIndexes.contains(pageIndex)
                  ? const Icon(Icons.settings_applications)
                  : const Icon(Icons.settings_applications_outlined),
              title: const Text('Configuración'),
              textColor: _configuracionPageIndexes.contains(pageIndex)
                  ? AppColors.azulPrincipal
                  : null,
              iconColor: _configuracionPageIndexes.contains(pageIndex)
                  ? AppColors.azulPrincipal
                  : null,
              children: [
                Container(
                  color: pageIndex == 4
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 4
                        ? const Icon(
                            Icons.group,
                            size: 15,
                          )
                        : const Icon(
                            Icons.group_outlined,
                            size: 15,
                          ),
                    title: const Text('Usuarios'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 4 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 4 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 4, Routes.usuarios);
                    },
                  ),
                ),
                Container(
                  color: pageIndex == 5
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 5
                        ? const Icon(
                            Icons.folder,
                            size: 15,
                          )
                        : const Icon(
                            Icons.folder_copy_outlined,
                            size: 15,
                          ),
                    title: const Text('Proyectos'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 5 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 5 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 5, Routes.proyectos);
                    },
                  ),
                ),
                Container(
                  color: pageIndex == 6
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 6
                        ? const Icon(
                            Icons.list_alt,
                            size: 15,
                          )
                        : const Icon(
                            Icons.list_alt_outlined,
                            size: 15,
                          ),
                    title: const Text('Componentes'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 6 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 6 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 6, Routes.componentes);
                    },
                  ),
                ),
                Container(
                  color: pageIndex == 7
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 7
                        ? const Icon(
                            Icons.bar_chart,
                            size: 15,
                          )
                        : const Icon(
                            Icons.bar_chart_outlined,
                            size: 15,
                          ),
                    title: const Text('Indicadores'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 7 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 7 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 7, Routes.indicadores);
                    },
                  ),
                ),
                Container(
                  color: pageIndex == 8
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 8
                        ? const Icon(
                            Icons.bookmark_outline,
                            size: 15,
                          )
                        : const Icon(
                            Icons.bookmark_outline_sharp,
                            size: 15,
                          ),
                    title: const Text('Compromiso, normativa\no ley'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 8 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 8 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 8, Routes.compromisos);
                    },
                  ),
                ),
                Container(
                  color: pageIndex == 9
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 9
                        ? const Icon(
                            Icons.person_2,
                            size: 15,
                          )
                        : const Icon(
                            Icons.person_2_outlined,
                            size: 15,
                          ),
                    title: const Text('Actores participantes'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 9 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 9 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 9, Routes.actores);
                    },
                  ),
                ),
                Container(
                  color: pageIndex == 10
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 10
                        ? const Icon(
                            Icons.group,
                            size: 15,
                          )
                        : const Icon(
                            Icons.group_outlined,
                            size: 15,
                          ),
                    title: const Text('Grupos beneficiarios'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 10 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 10 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 10, Routes.beneficiarios);
                    },
                  ),
                ),
                Container(
                  color: pageIndex == 11
                      ? AppColors.azulPrincipal.withOpacity(0.05)
                      : null,
                  child: ListTile(
                    dense: true,
                    trailing: pageIndex == 11
                        ? const Icon(
                            Icons.attach_money,
                            size: 15,
                          )
                        : const Icon(
                            Icons.attach_money_outlined,
                            size: 15,
                          ),
                    title: const Text('Fuentes de\nfinanciamiento'),
                    horizontalTitleGap: 40,
                    textColor: pageIndex == 11 ? AppColors.azulPrincipal : null,
                    iconColor: pageIndex == 11 ? AppColors.azulPrincipal : null,
                    onTap: () {
                      navigateTo(context, 11, Routes.fuentesFinanciamiento);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: pageIndex == 12
                ? AppColors.azulPrincipal.withOpacity(0.05)
                : null,
            child: ListTile(
                leading: pageIndex == 12
                    ? const Icon(Icons.file_copy)
                    : const Icon(Icons.file_copy_outlined),
                title: const Text('Gestión Documental'),
                textColor: pageIndex == 12 ? AppColors.azulPrincipal : null,
                iconColor: pageIndex == 12 ? AppColors.azulPrincipal : null,
                onTap: () {
                  navigateTo(context, 12, Routes.gestionDocumental);
                }),
          ),
          const Gap(25),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Ayuda',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: AppColors.azulPrincipal,
              ),
            ),
          ),
          const Gap(15),
          Container(
            color: pageIndex == 13
                ? AppColors.azulPrincipal.withOpacity(0.05)
                : null,
            child: ListTile(
                leading: pageIndex == 13
                    ? const Icon(Icons.video_collection)
                    : const Icon(Icons.video_collection_outlined),
                title: const Text('Tutoriales'),
                textColor: pageIndex == 13 ? AppColors.azulPrincipal : null,
                iconColor: pageIndex == 13 ? AppColors.azulPrincipal : null,
                onTap: () {
                  navigateTo(context, 13, Routes.tutoriales);
                }),
          ),
        ],
      ),
    );
  }

  //Intentar cerrar sesión
  Future<void> _tryLogout() async {
    setState(() => _isLoginOut = true);
    ref.read(authManagerProvider.notifier).tryLogout().then((message) {
      setState(() => _isLoginOut = false);
      if (message == 'success') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Cierre de sesión exitosa',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )));
        context.goNamed(Routes.login);
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )));
      }
    });
  }
}
