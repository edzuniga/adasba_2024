import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/domain/entities/componente.dart';
import 'package:adasba_2024/presentation/providers/componentes/componentes_repository_provider.dart';
import 'package:adasba_2024/presentation/providers/proyectos/proyectos_repository_provider.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/widgets/custom_input.dart';

class ComponentesModal extends ConsumerStatefulWidget {
  const ComponentesModal(
      {required this.titulo,
      required this.modalPurpose,
      this.componente,
      super.key});
  final String titulo;
  final ModalPurpose modalPurpose;
  final Componente? componente;

  @override
  ConsumerState<ComponentesModal> createState() => _ComponentesModalState();
}

class _ComponentesModalState extends ConsumerState<ComponentesModal> {
  final GlobalKey<FormState> _componentesFormKey = GlobalKey<FormState>();
  final TextEditingController _codigoComponenteController =
      TextEditingController();
  final TextEditingController _nombreComponenteController =
      TextEditingController();
  final TextEditingController _descripcionComponenteController =
      TextEditingController();
  final TextEditingController _resultadosEsperadosController =
      TextEditingController();
  List<DropdownMenuItem<int>> _itemsDropdown = [];
  int? _selectedIdProyecto;
  bool _isSendingData = false;
  late String _botonString;

  @override
  void initState() {
    super.initState();
    _botonString =
        widget.modalPurpose == ModalPurpose.add ? 'Agregar' : 'Editar';
    _getProyectosDropdownItems();
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
        _itemsDropdown = fetchedProyectos
            .map((item) =>
                DropdownMenuItem(value: item.id, child: Text(item.nombreCorto)))
            .toList();
      });
    });
  }

  Future<void> _getFieldValues() async {
    final componentesProvider = ref.read(getSpecificComponenteProvider);
    final componenteData =
        await componentesProvider.call(widget.componente!.id!);
    componenteData.fold((failure) {
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
      final proyectoData = await proyectoProvider.call(successData.idProyecto);
      proyectoData.fold((failure) {}, (proyecto) {
        proyecto.activo != 2
            ? _selectedIdProyecto = successData.idProyecto
            : null;
      });

      _codigoComponenteController.text = successData.codigoComponente;
      _nombreComponenteController.text = successData.nombreComponente;
      _descripcionComponenteController.text =
          successData.descripcionComponente ?? '';
      _resultadosEsperadosController.text =
          successData.resultadosEsperados ?? '';
      setState(() {});
    });
  }

  @override
  void dispose() {
    _codigoComponenteController.dispose();
    _nombreComponenteController.dispose();
    _descripcionComponenteController.dispose();
    _resultadosEsperadosController.dispose();
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
              key: _componentesFormKey,
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
                            '${widget.titulo} componente',
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
                              items: _itemsDropdown,
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

                    //Nombre
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _nombreComponenteController,
                              label: 'Nombre del componente',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Código
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _codigoComponenteController,
                              label: 'Código *(hasta 25 caracteres)',
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
                              controlador: _descripcionComponenteController,
                              label: 'Descripción del componente',
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Resultados esperados
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _resultadosEsperadosController,
                              label: 'Resultados esperados',
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
                                    if (_componentesFormKey.currentState!
                                        .validate()) {
                                      //Caso específico
                                      //Obtener los datos del storage
                                      final storage = LocalStorage();
                                      String? codaleaOrg =
                                          await storage.getCodaleaOrg();
                                      String? userId =
                                          await storage.getUserId();

                                      Componente componente = (widget
                                                  .modalPurpose ==
                                              ModalPurpose.add)
                                          ? Componente(
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: randomAlphaNumeric(15),
                                              idProyecto: _selectedIdProyecto!,
                                              nombreComponente:
                                                  _nombreComponenteController
                                                      .text,
                                              codigoComponente:
                                                  _codigoComponenteController
                                                      .text,
                                              descripcionComponente:
                                                  _descripcionComponenteController
                                                      .text,
                                              resultadosEsperados:
                                                  _resultadosEsperadosController
                                                      .text,
                                              activo: 1,
                                              fechaCreado: DateTime.now(),
                                              creadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                            )
                                          : Componente(
                                              id: widget.componente!.id,
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea:
                                                  widget.componente!.codalea,
                                              idProyecto: _selectedIdProyecto!,
                                              nombreComponente:
                                                  _nombreComponenteController
                                                      .text,
                                              codigoComponente:
                                                  _codigoComponenteController
                                                      .text,
                                              descripcionComponente:
                                                  _descripcionComponenteController
                                                      .text,
                                              resultadosEsperados:
                                                  _resultadosEsperadosController
                                                      .text,
                                              activo: 1,
                                              creadoPor: widget.componente!.id!,
                                              fechaCreado: widget
                                                  .componente!.fechaCreado,
                                              fechaModi: DateTime.now(),
                                              modificadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                            );
                                      (widget.modalPurpose == ModalPurpose.add)
                                          ? tryAddComponente(componente)
                                          : tryUpdateComponente(componente);
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
                        '${widget.titulo} componente',
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
                          await tryDeleteFuente(widget.componente!);
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

  Future<void> tryAddComponente(Componente componente) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(addComponenteProvider).call(componente);

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

  Future<void> tryUpdateComponente(Componente componente) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(updateComponenteProvider).call(componente);

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

  Future<void> tryDeleteFuente(Componente componente) async {
    setState(() => _isSendingData = true);
    final result =
        await ref.read(deleteComponenteProvider).call(componente.id!);

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
