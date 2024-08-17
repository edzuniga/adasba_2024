import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/domain/entities/user.dart';
import 'package:adasba_2024/presentation/providers/grupos/grupos_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/table_to_excel.dart';
import 'package:adasba_2024/presentation/dashboard/modales/usuario_modal.dart';
import 'package:adasba_2024/presentation/dashboard/data_table_sources/usuarios_dts.dart';
import 'package:adasba_2024/presentation/providers/users/users_manager.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/constants/table_styles.dart';

class UsuariosView extends ConsumerStatefulWidget {
  const UsuariosView({super.key});

  @override
  ConsumerState<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends ConsumerState<UsuariosView> {
  Timer? _timer;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isGeneratingExcel = false;

  @override
  void initState() {
    super.initState();
    _startPolling(); //inicia el contador para refrescar datos
    _searchController.addListener(_onSearchChanged); //listener para el buscador
  }

  //Función para refescar los datos cada 30 minutos (para mantenerlo actualizado)
  void _startPolling() {
    _timer = Timer.periodic(const Duration(minutes: 30), (timer) {
      ref.read(usuariosManagerProvider.notifier).refresh();
    });
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = ref.watch(usuariosManagerProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(20),
            Center(
              child: Text(
                'Tabla de usuarios',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Gap(15),
            //BUSCADOR
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 350,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    label: const Text('Nombre | apellido | correo'),
                    hintText: 'Puede buscar por nombre, apellido o correo',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    suffixIcon: const Icon(Icons.search),
                    labelStyle: GoogleFonts.roboto(
                      color: const Color(0xFF7E828E),
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.azulPrincipal,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: usuarios.when(
                data: (usuarios) {
                  //Lógica de filtrado
                  final filteredUsuarios = _searchQuery.isEmpty
                      ? usuarios
                      : usuarios.where((usuario) {
                          final nombres = usuario.nombres.toLowerCase();
                          final apellidos = usuario.apellidos.toLowerCase();
                          final correo = usuario.correo.toLowerCase();
                          return nombres.contains(_searchQuery) ||
                              apellidos.contains(_searchQuery) ||
                              correo.contains(_searchQuery);
                        }).toList();
                  final usuariosDTS = UsuariosTableSource(
                    data: filteredUsuarios,
                    ref: ref,
                    context: context,
                  );
                  if (usuarios.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'No hay usuarios aún\nAgrega tu primer usuario aquí.',
                            style: TextStyle(
                              color: AppColors.azulPrincipal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(10),
                          IconButton(
                            onPressed: () async {
                              await _addUsuarioModal();
                            },
                            tooltip: 'Agregar',
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.rojoPrincipal,
                            ),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (filteredUsuarios.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning_amber),
                          Gap(10),
                          Text(
                            'No se encontraron usuarios.',
                            style: TextStyle(
                              color: AppColors.azulPrincipal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: PaginatedDataTable(
                      headingRowColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        return AppColors.azulPrincipal.withOpacity(0.05);
                      }),
                      showFirstLastButtons: true,
                      header: const SizedBox(),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            await _generateDataRowsAndExcelArchive(
                                filteredUsuarios);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.amarilloPrincipal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                          child: _isGeneratingExcel
                              ? SpinPerfect(
                                  infinite: true,
                                  child: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ))
                              : const Text(
                                  'Exportar tabla',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await _addUsuarioModal();
                          },
                          tooltip: 'Agregar',
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.rojoPrincipal,
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      columns: <DataColumn>[
                        DataColumn(
                          numeric: true,
                          label: Text(
                            '#',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Foto',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nombres',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Apellidos',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Correo',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Grupos beneficiarios',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Rol',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Acciones',
                            style: CustomTableStyle.estiloTitulos,
                          ),
                        ),
                      ],
                      source: usuariosDTS,
                    ),
                  );
                },
                error: (error, _) => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ocurrió un error - pruebe nuevamente!!',
                        style: TextStyle(
                          color: AppColors.rojoPrincipal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                loading: () => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Por favor espere',
                        style: TextStyle(
                          color: AppColors.azulPrincipal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircularProgressIndicator(
                        color: AppColors.azulPrincipal,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addUsuarioModal() async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: UsuarioModal(
          titulo: 'Agregar',
          modalPurpose: ModalPurpose.add,
        ),
      ),
    );

    if (res) {
      ref.read(usuariosManagerProvider.notifier).refresh();
    }
  }

  Future<void> _generateDataRowsAndExcelArchive(List<User> usuarios) async {
    setState(() => _isGeneratingExcel = true);
    final List<List<String>> rows = [];
    //Generar los headers
    rows.add(['Nombres', 'Apellidos', 'Correo', 'Grupos beneficiarios', 'Rol']);

    //Generar los datos (rows de datos)
    for (int i = 0; i < usuarios.length; i++) {
      List<int> grupoIds =
          usuarios[i].gruposBeneficiarios.split(',').map(int.parse).toList();

      String nombresGruposString = await _getGruposNombres(grupoIds);

      rows.add([
        usuarios[i].nombres,
        usuarios[i].apellidos,
        usuarios[i].correo,
        nombresGruposString,
        usuarios[i].rol
      ]);
    }
    await _createExcelFile(rows);
    setState(() => _isGeneratingExcel = false);
  }

  Future<void> _createExcelFile(List<List<String>> rows) async {
    String mensaje = await CreateExcel.tableToExcel(rows);

    if (mensaje != 'success') {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Ocurrió un error al intentar crear el archivo de excel!!',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  // Función auxiliar para obtener los nombres de los grupos beneficiarios
  Future<String> _getGruposNombres(List<int> grupoIds) async {
    String nombreGrupos = '';
    for (var id in grupoIds) {
      final response = await ref.read(getSpecificGrupoProvider).call(id);
      response.fold((failure) {
        throw const ServerFailure(message: 'Ocurrió un error');
      }, (grupo) {
        nombreGrupos += '${grupo.nombre}, ';
      });
    }
    nombreGrupos = nombreGrupos.trimRight();
    if (nombreGrupos.endsWith(',')) {
      nombreGrupos = nombreGrupos.substring(0, nombreGrupos.length - 1);
    }
    return nombreGrupos;
  }
}
