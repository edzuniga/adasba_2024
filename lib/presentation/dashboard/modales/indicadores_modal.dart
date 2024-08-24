import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

import 'package:adasba_2024/domain/entities/indicador.dart';
import 'package:adasba_2024/presentation/providers/compromisos_ley/compromisos_repository_provider.dart';
import 'package:adasba_2024/presentation/providers/indicadores/indicadores_repository_provider.dart';
import 'package:adasba_2024/presentation/providers/componentes/componentes_repository_provider.dart';
import 'package:adasba_2024/presentation/providers/proyectos/proyectos_repository_provider.dart';
import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/widgets/custom_input.dart';

class IndicadoresModal extends ConsumerStatefulWidget {
  const IndicadoresModal(
      {required this.titulo,
      required this.modalPurpose,
      this.indicador,
      super.key});
  final String titulo;
  final ModalPurpose modalPurpose;
  final Indicador? indicador;

  @override
  ConsumerState<IndicadoresModal> createState() => _IndicadoresModalState();
}

class _IndicadoresModalState extends ConsumerState<IndicadoresModal> {
  final GlobalKey<FormState> _indicadoresFormKey = GlobalKey<FormState>();
  final TextEditingController _numeroIndicadorController =
      TextEditingController();
  final TextEditingController _nombreIndicadorController =
      TextEditingController();
  final TextEditingController _nombreCortoIndicadorController =
      TextEditingController();
  final TextEditingController _descripcionIndicadorController =
      TextEditingController();
  final TextEditingController _c0Controller = TextEditingController();
  final TextEditingController _c1Controller = TextEditingController();
  final TextEditingController _c2Controller = TextEditingController();
  final TextEditingController _c3Controller = TextEditingController();
  final TextEditingController _c4Controller = TextEditingController();
  final TextEditingController _c5Controller = TextEditingController();
  final TextEditingController _fuentesController = TextEditingController();
  List<DropdownMenuItem<int>> _itemsProyectoDropdown = [];
  int? _selectedIdProyecto;
  List<DropdownMenuItem<int>> _itemsComponenteDropdown = [];
  int? _selectedIdComponente;
  List<DropdownMenuItem<int>> _itemsCompromisoDropdown = [];
  int? _selectedIdCompromiso;
  int _tipoIndicador = 1;

  bool _isSendingData = false;
  late String _botonString;

  @override
  void initState() {
    super.initState();
    _botonString =
        widget.modalPurpose == ModalPurpose.add ? 'Agregar' : 'Editar';
    _getProyectosDropdownItems();
    _getComponentesDropdownItems();
    _getCompromisosDropdownItems();
    if (widget.modalPurpose == ModalPurpose.update) {
      _getFieldValues();
    }
  }

  Future<void> _getProyectosDropdownItems() async {
    LocalStorage storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    final proyectosProvider =
        await ref.read(getAllProyectosProvider).call(codaleaOrg!);
    proyectosProvider.fold((failure) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.rojoPrincipal,
          content: Text(
            'Error al intentar cargar la información de los proyectos -> ${failure.message}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }, (fetchedProyectos) async {
      setState(() {
        _itemsProyectoDropdown = fetchedProyectos
            .map((item) =>
                DropdownMenuItem(value: item.id, child: Text(item.nombreCorto)))
            .toList();
      });
    });
  }

  Future<void> _getComponentesDropdownItems() async {
    LocalStorage storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    final componentesProvider =
        await ref.read(getAllComponentesProvider).call(codaleaOrg!);
    componentesProvider.fold((failure) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.rojoPrincipal,
          content: Text(
            'Error al intentar cargar la información de los componentes -> ${failure.message}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }, (fetchedComponentes) async {
      setState(() {
        _itemsComponenteDropdown = fetchedComponentes
            .map((item) => DropdownMenuItem(
                value: item.id, child: Text(item.nombreComponente)))
            .toList();
      });
    });
  }

  Future<void> _getCompromisosDropdownItems() async {
    LocalStorage storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    final compromisosProvider =
        await ref.read(getAllCompromisosProvider).call(codaleaOrg!);
    compromisosProvider.fold((failure) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.rojoPrincipal,
          content: Text(
            'Error al intentar cargar la información de los compromisos -> ${failure.message}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }, (fetchedCompromisos) async {
      setState(() {
        _itemsCompromisoDropdown = fetchedCompromisos
            .map((item) =>
                DropdownMenuItem(value: item.id, child: Text(item.nombre)))
            .toList();
      });
    });
  }

  Future<void> _getFieldValues() async {
    final indicadoresProvider = ref.read(getSpecificIndicadorProvider);
    final indicadorData = await indicadoresProvider.call(widget.indicador!.id!);
    indicadorData.fold((failure) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.rojoPrincipal,
          content: Text(
            'Error al intentar cargar la información del registro -> ${failure.message}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }, (successData) async {
      //Revisar que los items seleccionados en los dropdowns estén ACTIVOS
      final proyectoProvider = ref.read(getSpecificProyectoProvider);
      final proyectoData =
          await proyectoProvider.call(successData.proyectoRelacionado);
      proyectoData.fold((failure) {}, (proyecto) {
        proyecto.activo != 2
            ? _selectedIdProyecto = successData.proyectoRelacionado
            : null;
      });

      final componenteProvider = ref.read(getSpecificComponenteProvider);
      final componenteData =
          await componenteProvider.call(successData.componenteRelacionado);
      componenteData.fold((failure) {}, (componente) {
        componente.activo != 2
            ? _selectedIdComponente = successData.componenteRelacionado
            : null;
      });

      final compromisoProvider = ref.read(getSpecificCompromisoLeyProvider);
      final compromisoData = successData.compromisoRelacionado != null
          ? await compromisoProvider.call(successData.compromisoRelacionado!)
          : null;
      if (compromisoData != null) {
        compromisoData.fold((failure) {}, (compromiso) {
          compromiso.activo != 2
              ? _selectedIdCompromiso = successData.compromisoRelacionado
              : null;
        });
      }

      _numeroIndicadorController.text = successData.numeroIndicador;
      _nombreIndicadorController.text = successData.nombreIndicador;
      _nombreCortoIndicadorController.text = successData.nombreCortoIndicador;
      _descripcionIndicadorController.text =
          successData.descripcionIndicador ?? '';
      _c0Controller.text = successData.c0;
      _c1Controller.text = successData.c1 ?? '';
      _c2Controller.text = successData.c2 ?? '';
      _c3Controller.text = successData.c3 ?? '';
      _c4Controller.text = successData.c4 ?? '';
      _c5Controller.text = successData.c5;
      _fuentesController.text = successData.fuentesVerificacion ?? '';
      _tipoIndicador = successData.tipoIndicador;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _numeroIndicadorController.dispose();
    _nombreIndicadorController.dispose();
    _nombreCortoIndicadorController.dispose();
    _descripcionIndicadorController.dispose();
    _c0Controller.dispose();
    _c1Controller.dispose();
    _c2Controller.dispose();
    _c3Controller.dispose();
    _c4Controller.dispose();
    _c5Controller.dispose();
    _fuentesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight:
            widget.modalPurpose == ModalPurpose.delete ? 280 : double.infinity,
        maxWidth: widget.modalPurpose == ModalPurpose.delete
            ? double.minPositive
            : 800,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: widget.modalPurpose != ModalPurpose.delete
          ? Form(
              key: _indicadoresFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Título del modal
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: const BoxDecoration(
                          color: AppColors.azulPrincipal,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.titulo} indicador',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: () => context.pop(false),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Número indicador
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _numeroIndicadorController,
                              label: 'Número indicador (*15 caracteres máximo)',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Nombre completo indicador
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _nombreIndicadorController,
                              label: 'Nombre del indicador',
                              isTextArea: true,
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Nombre CORTO indicador
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _nombreCortoIndicadorController,
                              label: 'Nombre corto (*45 caracteres máximo)',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Descripción
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _descripcionIndicadorController,
                              label: 'Descripción del indicador',
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Proyecto dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedIdProyecto,
                              items: _itemsProyectoDropdown,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                    Icons.settings_applications_outlined),
                                labelText: 'Proyecto',
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
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedIdProyecto = value);
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Campo obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Componente dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedIdComponente,
                              items: _itemsComponenteDropdown,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                    Icons.settings_applications_outlined),
                                labelText: 'Componente relacionado',
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
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedIdComponente = value);
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Campo obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Compromiso dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _selectedIdCompromiso,
                              items: _itemsCompromisoDropdown,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                    Icons.settings_applications_outlined),
                                labelText: 'Compromiso relacionado',
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
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedIdCompromiso = value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Tipo de indicador
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Tipo'),
                          const Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => _tipoIndicador = 1);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _tipoIndicador == 1
                                      ? Colors.blue
                                      : Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.5,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Global',
                                  style: TextStyle(
                                    color: _tipoIndicador == 1
                                        ? Colors.white
                                        : Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() => _tipoIndicador = 2);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _tipoIndicador == 2
                                      ? Colors.green
                                      : Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.5,
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Parcial',
                                  style: TextStyle(
                                    color: _tipoIndicador == 2
                                        ? Colors.white
                                        : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //C0
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _c0Controller,
                              label: '0 ->',
                              isTextArea: true,
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //C1
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _c1Controller,
                              label: '1 ->',
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //C2
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _c2Controller,
                              label: '2 ->',
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //C3
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _c3Controller,
                              label: '3 ->',
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //C4
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _c4Controller,
                              label: '4 ->',
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //C5
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _c5Controller,
                              label: '5 ->',
                              isTextArea: true,
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Fuentes comunes de verificación
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _fuentesController,
                              label: 'Fuentes comunes de verificación',
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Botones cancelar y agregar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //Botón de cancelar
                          ElevatedButton(
                            onPressed: () => context.pop(false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.amarilloPrincipal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cancelar',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Gap(10),
                          //Botón de agregar
                          ElevatedButton(
                            onPressed: _isSendingData
                                ? () {}
                                : () async {
                                    if (_indicadoresFormKey.currentState!
                                        .validate()) {
                                      //Obtener los datos del storage
                                      final storage = LocalStorage();
                                      String? codaleaOrg =
                                          await storage.getCodaleaOrg();
                                      String? userId =
                                          await storage.getUserId();

                                      Indicador indicador = (widget
                                                  .modalPurpose ==
                                              ModalPurpose.add)
                                          ? Indicador(
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: randomAlphaNumeric(15),
                                              numeroIndicador:
                                                  _numeroIndicadorController
                                                      .text,
                                              tipoIndicador: _tipoIndicador,
                                              proyectoRelacionado:
                                                  _selectedIdProyecto!,
                                              componenteRelacionado:
                                                  _selectedIdComponente!,
                                              compromisoRelacionado:
                                                  _selectedIdCompromiso,
                                              nombreIndicador:
                                                  _nombreIndicadorController
                                                      .text,
                                              nombreCortoIndicador:
                                                  _nombreCortoIndicadorController
                                                      .text,
                                              descripcionIndicador:
                                                  _descripcionIndicadorController
                                                      .text,
                                              c0: _c0Controller.text,
                                              c1: _c1Controller.text,
                                              c2: _c2Controller.text,
                                              c3: _c3Controller.text,
                                              c4: _c4Controller.text,
                                              c5: _c5Controller.text,
                                              fuentesVerificacion:
                                                  _fuentesController.text,
                                              activo: 1,
                                              fechaCreado: DateTime.now(),
                                              creadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                            )
                                          : Indicador(
                                              id: widget.indicador!.id,
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea:
                                                  widget.indicador!.codalea,
                                              numeroIndicador:
                                                  _numeroIndicadorController
                                                      .text,
                                              tipoIndicador: _tipoIndicador,
                                              proyectoRelacionado:
                                                  _selectedIdProyecto!,
                                              componenteRelacionado:
                                                  _selectedIdComponente!,
                                              compromisoRelacionado:
                                                  _selectedIdCompromiso,
                                              nombreIndicador:
                                                  _nombreIndicadorController
                                                      .text,
                                              nombreCortoIndicador:
                                                  _nombreCortoIndicadorController
                                                      .text,
                                              descripcionIndicador:
                                                  _descripcionIndicadorController
                                                      .text,
                                              c0: _c0Controller.text,
                                              c1: _c1Controller.text,
                                              c2: _c2Controller.text,
                                              c3: _c3Controller.text,
                                              c4: _c4Controller.text,
                                              c5: _c5Controller.text,
                                              fuentesVerificacion:
                                                  _fuentesController.text,
                                              activo: 1,
                                              creadoPor: widget.indicador!.id!,
                                              fechaCreado:
                                                  widget.indicador!.fechaCreado,
                                              fechaModi: DateTime.now(),
                                              modificadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                            );
                                      (widget.modalPurpose == ModalPurpose.add)
                                          ? tryAddIndicador(indicador)
                                          : tryUpdateIndicador(indicador);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.rojoPrincipal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isSendingData
                                ? SpinPerfect(
                                    infinite: true,
                                    child: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    _botonString,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Título del modal
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: const BoxDecoration(
                      color: AppColors.azulPrincipal,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.titulo} indicador',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.pop(false),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(15),
                const Icon(
                  Icons.warning_amber,
                  color: AppColors.rojoPrincipal,
                  size: 50,
                ),
                const Gap(15),
                Text(
                  '¿Estás seguro que deseas borrar el registro?',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                //Botones cancelar y aceptar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Botón de cancelar
                      ElevatedButton(
                        onPressed: () => context.pop(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amarilloPrincipal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cancelar',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Gap(10),
                      //Botón de aceptar
                      ElevatedButton(
                        onPressed: () async {
                          await tryDeleteIndicador(widget.indicador!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rojoPrincipal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Aceptar',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> tryAddIndicador(Indicador indicador) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(addIndicadorProvider).call(indicador);

    result.fold(
      (failure) {
        setState(() => _isSendingData = false);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.rojoPrincipal,
            content: Text(
              'Error al intentar agregar el registro -> ${failure.message}',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      (success) {
        setState(() => _isSendingData = false);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.verdePrincipal,
            content: Text(
              'Registro agregado exitosamente',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
        context.pop(true);
      },
    );
  }

  Future<void> tryUpdateIndicador(Indicador indicador) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(updateIndicadorProvider).call(indicador);

    result.fold(
      (failure) {
        setState(() => _isSendingData = false);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.rojoPrincipal,
            content: Text(
              'Error al intentar actualizar el registro -> ${failure.message}',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      (success) {
        setState(() => _isSendingData = false);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.azulPrincipal,
            content: Text(
              'Registro actualizado exitosamente',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
        context.pop(true);
      },
    );
  }

  Future<void> tryDeleteIndicador(Indicador indicador) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(deleteIndicadorProvider).call(indicador.id!);

    result.fold(
      (failure) {
        setState(() => _isSendingData = false);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.rojoPrincipal,
            content: Text(
              'Error al intentar borrar el registro -> ${failure.message}',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      (success) {
        setState(() => _isSendingData = false);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.amarilloPrincipal,
            content: Text(
              'Registro borrado exitosamente',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
        context.pop(true);
      },
    );
  }
}
