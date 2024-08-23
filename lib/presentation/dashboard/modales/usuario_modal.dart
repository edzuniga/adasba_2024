import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

import 'package:adasba_2024/presentation/providers/grupos/grupos_repository_provider.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/domain/entities/user.dart';
import 'package:adasba_2024/presentation/providers/users/users_repository_provider.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/widgets/custom_input.dart';

class UsuarioModal extends ConsumerStatefulWidget {
  const UsuarioModal(
      {required this.titulo, required this.modalPurpose, this.user, super.key});
  final String titulo;
  final ModalPurpose modalPurpose;
  final User? user;

  @override
  ConsumerState<UsuarioModal> createState() => _UsuarioModalState();
}

class _UsuarioModalState extends ConsumerState<UsuarioModal> {
  final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final List<MultiSelectItem<int>> _itemsGruposBeneficiarios = [];
  List<int> _selectedGruposBeneficiarios = [];
  String? _selectedRol;
  bool _isSendingData = false;
  bool _isMultiSelectValidated = true;
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
    final userProvider = ref.read(getSpecificUserProvider);
    final userData = await userProvider.call(widget.user!.id!);
    userData.fold((failure) {
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
    }, (successUserData) async {
      //Crear List<int> de los grupos beneficiarios
      _selectedGruposBeneficiarios = successUserData.gruposBeneficiarios
          .split(',')
          .map((e) => int.parse(e))
          .toList();

      _nombresController.text = successUserData.nombres;
      _apellidosController.text = successUserData.apellidos;
      _correoController.text = successUserData.correo;
      _contrasenaController.text = successUserData.contrasena ?? '';
      _selectedRol = successUserData.rol;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _apellidosController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
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
              key: _userFormKey,
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
                            '${widget.titulo} usuario',
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
                    //Nombres
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _nombresController,
                              label: 'Nombres',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Apellidos
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _apellidosController,
                              label: 'Apellidos',
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Correo
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _correoController,
                              label: 'Correo',
                              isEmail: true,
                              iconito: Icons.email,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Contraseña
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              controlador: _contrasenaController,
                              label: widget.modalPurpose == ModalPurpose.update
                                  ? '*Escriba aquí solo si desea cambiar la contraseña'
                                  : 'Contraseña',
                              isRequired:
                                  widget.modalPurpose == ModalPurpose.update
                                      ? false
                                      : true,
                              isPassword: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Rol
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedRol,
                              items: const [
                                DropdownMenuItem(
                                    value: 'admin',
                                    child: Text('Administrador')),
                                DropdownMenuItem(
                                    value: 'supervisor',
                                    child: Text('Supervisor')),
                                DropdownMenuItem(
                                    value: 'ejecutor', child: Text('Ejecutor')),
                                DropdownMenuItem(
                                    value: 'veedor', child: Text('Veedor')),
                              ],
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                    Icons.settings_applications_outlined),
                                labelText: 'Rol',
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
                                  setState(() => _selectedRol = value);
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
                    //grupos beneficiarios
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MultiSelectDialogField<int>(
                              initialValue: _selectedGruposBeneficiarios,
                              items: _itemsGruposBeneficiarios,
                              cancelText: const Text('Cancelar'),
                              confirmText: const Text('Aceptar'),
                              title: const Text("Seleccionar los que apliquen"),
                              selectedColor: AppColors.azulPrincipal,
                              backgroundColor: Colors.white,
                              dialogWidth:
                                  MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: _isMultiSelectValidated ? 0.5 : 1.0,
                                  color: _isMultiSelectValidated
                                      ? Colors.black12
                                      : Colors.red,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                              ),
                              buttonIcon: const Icon(Icons.group),
                              buttonText: Text(
                                'Grupos beneficiarios',
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF7E828E),
                                  fontSize: 14,
                                ),
                              ),
                              onConfirm: (values) {
                                if (values.isNotEmpty) {
                                  _selectedGruposBeneficiarios.clear();
                                  for (var element in values) {
                                    _selectedGruposBeneficiarios.add(element);
                                  }
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(
                                      () => _isMultiSelectValidated = false);

                                  return 'Campo obligatorio';
                                }
                                setState(() => _isMultiSelectValidated = true);
                                return null;
                              },
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
                                    if (_userFormKey.currentState!.validate()) {
                                      //Obtener los datos del storage
                                      final storage = LocalStorage();
                                      String? codaleaOrg =
                                          await storage.getCodaleaOrg();
                                      String? userId =
                                          await storage.getUserId();

                                      String gruposBeneficiariosIds =
                                          transformGruposToStringOfIds(
                                              _selectedGruposBeneficiarios);
                                      User usuario = (widget.modalPurpose ==
                                              ModalPurpose.add)
                                          ? User(
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: randomAlphaNumeric(15),
                                              correo: _correoController.text,
                                              contrasena:
                                                  _contrasenaController.text,
                                              nombres: _nombresController.text,
                                              apellidos:
                                                  _apellidosController.text,
                                              rol: _selectedRol!,
                                              activo: 1,
                                              creadoPor:
                                                  int.tryParse(userId!) ?? 1,
                                              fechaCreado: DateTime.now(),
                                              gruposBeneficiarios:
                                                  gruposBeneficiariosIds,
                                            )
                                          : User(
                                              id: widget.user!.id,
                                              codaleaOrg: codaleaOrg.toString(),
                                              codalea: widget.user!.codalea,
                                              correo: _correoController.text,
                                              contrasena:
                                                  _contrasenaController.text,
                                              nombres: _nombresController.text,
                                              apellidos:
                                                  _apellidosController.text,
                                              rol: _selectedRol!,
                                              activo: 1,
                                              creadoPor: widget.user!.id!,
                                              fechaCreado:
                                                  widget.user!.fechaCreado,
                                              gruposBeneficiarios:
                                                  gruposBeneficiariosIds,
                                              fechaModificado: DateTime.now(),
                                            );
                                      (widget.modalPurpose == ModalPurpose.add)
                                          ? tryAddUsuario(usuario)
                                          : tryUpdateUsuario(usuario);
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
                        '${widget.titulo} usuario',
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
                          await tryDeleteUsuario(widget.user!);
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

  Future<void> tryAddUsuario(User usuario) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(addUserProvider).call(usuario);

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

  Future<void> tryUpdateUsuario(User usuario) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(updateUserProvider).call(usuario);

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

  Future<void> tryDeleteUsuario(User usuario) async {
    setState(() => _isSendingData = true);
    final result = await ref.read(deleteUserProvider).call(usuario.id!);

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
