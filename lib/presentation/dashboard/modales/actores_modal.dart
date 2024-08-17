import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

import 'package:adasba_2024/domain/entities/actor.dart';
import 'package:adasba_2024/presentation/providers/actores/actores_repository_provider.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/widgets/custom_input.dart';

class ActoresModal extends ConsumerStatefulWidget {
  const ActoresModal(
      {required this.titulo,
      required this.modalPurpose,
      this.actor,
      super.key});
  final String titulo;
  final ModalPurpose modalPurpose;
  final Actor? actor;

  @override
  ConsumerState<ActoresModal> createState() => _ActoresModalState();
}

class _ActoresModalState extends ConsumerState<ActoresModal> {
  final GlobalKey<FormState> _actoresFormKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  bool _isSendingData = false;
  late String _botonString;

  @override
  void initState() {
    super.initState();
    _botonString =
        widget.modalPurpose == ModalPurpose.add ? 'Agregar' : 'Editar';
    if (widget.modalPurpose == ModalPurpose.update) {
      _getFieldValues();
    }
  }

  Future<void> _getFieldValues() async {
    final actoresProvider = ref.read(getSpecificActorProvider);
    final actorData = await actoresProvider.call(widget.actor!.id!);
    actorData.fold((failure) {
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
      _nombreController.text = successData.nombre;
      _descripcionController.text = successData.descripcion;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
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
              key: _actoresFormKey,
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
                            '${widget.titulo} actor participante',
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
                    //Nombre
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _nombreController,
                              label: 'Nombre',
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
                                    if (_actoresFormKey.currentState!
                                        .validate()) {
                                      //Obtener los datos del storage
                                      final storage = SecureStorage();
                                      String? codaleaOrg =
                                          await storage.getCodaleaOrg();
                                      String? userId =
                                          await storage.getUserId();

                                      Actor actor = (widget.modalPurpose ==
                                              ModalPurpose.add)
                                          ? Actor(
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: randomAlphaNumeric(15),
                                              nombre: _nombreController.text,
                                              descripcion:
                                                  _descripcionController.text,
                                              activo: 1,
                                              creadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                              fechaCreado: DateTime.now(),
                                            )
                                          : Actor(
                                              id: widget.actor!.id,
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: widget.actor!.codalea,
                                              nombre: _nombreController.text,
                                              descripcion:
                                                  _descripcionController.text,
                                              activo: 1,
                                              creadoPor: widget.actor!.id!,
                                              fechaCreado:
                                                  widget.actor!.fechaCreado,
                                              fechaModi: DateTime.now(),
                                              modificadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                            );
                                      (widget.modalPurpose == ModalPurpose.add)
                                          ? tryAddActor(actor)
                                          : tryUpdateActor(actor);
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
                        '${widget.titulo} actor participante',
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
                          await tryDeleteActor(widget.actor!);
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

  Future<void> tryAddActor(Actor actor) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(addActorProvider).call(actor);

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

  Future<void> tryUpdateActor(Actor actor) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(updateActorProvider).call(actor);

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

  Future<void> tryDeleteActor(Actor actor) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(deleteActorProvider).call(actor.id!);

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
