import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

import 'package:adasba_2024/domain/entities/proyecto.dart';
import 'package:adasba_2024/presentation/providers/proyectos/proyectos_repository_provider.dart';
import 'package:adasba_2024/presentation/widgets/multiselect_input.dart';
import 'package:adasba_2024/presentation/providers/grupos/grupos_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/widgets/custom_input.dart';

class ProyectoModal extends ConsumerStatefulWidget {
  const ProyectoModal(
      {required this.titulo,
      required this.modalPurpose,
      this.proyecto,
      super.key});
  final String titulo;
  final ModalPurpose modalPurpose;
  final Proyecto? proyecto;

  @override
  ConsumerState<ProyectoModal> createState() => _ProyectoModalState();
}

class _ProyectoModalState extends ConsumerState<ProyectoModal> {
  final GlobalKey<FormState> _proyectoFormKey = GlobalKey<FormState>();
  final TextEditingController _nombreProyectoController =
      TextEditingController();
  final TextEditingController _nombreCortoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final List<MultiSelectItem<int>> _itemsGruposBeneficiarios = [];
  List<int> _selectedGruposBeneficiarios = [];
  bool _isSendingData = false;
  late String _botonString;

  @override
  void initState() {
    super.initState();
    _botonString =
        widget.modalPurpose == ModalPurpose.add ? 'Agregar' : 'Editar';
    _getMultiSelectItems();
    if (widget.modalPurpose == ModalPurpose.update) {
      _getFieldValues();
    }
  }

  Future<void> _getMultiSelectItems() async {
    final storage = LocalStorage();
    String? codaleaOrg = await storage.getCodaleaOrg();
    final result =
        await ref.read(getAllGruposProvider).call(codaleaOrg.toString());
    result.fold((failure) {
      throw const ServerFailure(
          message: 'Error al querer obtener grupos beneficiarios');
    }, (grupos) {
      grupos
          .map((grupo) => _itemsGruposBeneficiarios
              .add(MultiSelectItem<int>(grupo.id!, grupo.nombre)))
          .toList();
    });
  }

  Future<void> _getFieldValues() async {
    final proyectoProvider = ref.read(getSpecificProyectoProvider);
    final proyectoData = await proyectoProvider.call(widget.proyecto!.id!);
    proyectoData.fold((failure) {
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
      //Crear List<int> de los grupos beneficiarios
      _selectedGruposBeneficiarios = successData.gruposRelacionados
          .split(',')
          .map((e) => int.parse(e))
          .toList();

      _nombreProyectoController.text = successData.nombreProyecto;
      _nombreCortoController.text = successData.nombreCorto;
      _descripcionController.text = successData.descripcion;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nombreProyectoController.dispose();
    _nombreCortoController.dispose();
    _descripcionController.dispose();
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
              key: _proyectoFormKey,
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
                            '${widget.titulo} proyecto',
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
                    //Nombre del proyecto
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _nombreProyectoController,
                              label: 'Nombre del proyecto',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Nombre corto
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _nombreCortoController,
                              label: 'Nombre corto',
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
                              controlador: _descripcionController,
                              label: 'Descripción',
                              isRequired: true,
                              isTextArea: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //grupos beneficiarios
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MultiSelectCustomInput(
                              selectedValues: _selectedGruposBeneficiarios,
                              listado: _itemsGruposBeneficiarios,
                              label: 'Grupos beneficiarios',
                              isRequired: true,
                              iconito: Icons.group,
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
                                    if (_proyectoFormKey.currentState!
                                        .validate()) {
                                      //Obtener los datos del storage
                                      final storage = LocalStorage();
                                      String? codaleaOrg =
                                          await storage.getCodaleaOrg();
                                      String? userId =
                                          await storage.getUserId();

                                      String gruposBeneficiariosIds =
                                          transformGruposToStringOfIds(
                                              _selectedGruposBeneficiarios);
                                      Proyecto proyecto = (widget
                                                  .modalPurpose ==
                                              ModalPurpose.add)
                                          ? Proyecto(
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: randomAlphaNumeric(15),
                                              nombreProyecto:
                                                  _nombreProyectoController
                                                      .text,
                                              nombreCorto:
                                                  _nombreCortoController.text,
                                              descripcion:
                                                  _descripcionController.text,
                                              gruposRelacionados:
                                                  gruposBeneficiariosIds,
                                              activo: 1,
                                              creadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                              fechaCreado: DateTime.now(),
                                            )
                                          : Proyecto(
                                              id: widget.proyecto!.id,
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: widget.proyecto!.codalea,
                                              nombreProyecto:
                                                  _nombreProyectoController
                                                      .text,
                                              nombreCorto:
                                                  _nombreCortoController.text,
                                              descripcion:
                                                  _descripcionController.text,
                                              gruposRelacionados:
                                                  gruposBeneficiariosIds,
                                              activo: 1,
                                              creadoPor: widget.proyecto!.id!,
                                              fechaCreado:
                                                  widget.proyecto!.fechaCreado,
                                              fechaModi: DateTime.now(),
                                              modificadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                            );
                                      (widget.modalPurpose == ModalPurpose.add)
                                          ? tryAddProyecto(proyecto)
                                          : tryUpdateProyecto(proyecto);
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
                        '${widget.titulo} proyecto',
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
                          await tryDeleteProyecto(widget.proyecto!);
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

  Future<void> tryAddProyecto(Proyecto proyecto) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(addProyectoProvider).call(proyecto);

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

  Future<void> tryUpdateProyecto(Proyecto proyecto) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(updateProyectoProvider).call(proyecto);

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

  Future<void> tryDeleteProyecto(Proyecto proyecto) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(deleteProyectoProvider).call(proyecto.id!);

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

String transformGruposToStringOfIds(List<int> grupos) {
  String retorno = '';

  if (grupos.isNotEmpty) {
    for (int grupo in grupos) {
      retorno += '$grupo, ';
    }
    retorno = retorno.trimRight();
    if (retorno.endsWith(',')) {
      retorno = retorno.substring(0, retorno.length - 1);
    }
  }
  return retorno;
}
