import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adasba_2024/presentation/dashboard/modales/usuario_modal.dart';
import 'package:adasba_2024/presentation/providers/users/users_manager.dart';
import 'package:adasba_2024/utilities/add_update_delete_enum.dart';
import 'package:adasba_2024/utilities/error_manager.dart';
import 'package:adasba_2024/presentation/providers/grupos/grupos_repository_provider.dart';
import 'package:adasba_2024/domain/entities/user.dart';
import 'package:adasba_2024/constants/app_colors.dart';

class UsuariosTableSource extends DataTableSource {
  UsuariosTableSource(
      {required this.data, required this.ref, required this.context});
  final List<User> data;
  final WidgetRef ref;
  final BuildContext context;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  //DATOS SERIALIZADOS QUE VIENEN DE LA BD
  @override
  DataRow? getRow(int index) {
    User usuario = data[index];
    //Create array from usuario.gruposBeneficiarios
    List<int> listGruposBeneficiariosId =
        usuario.gruposBeneficiarios.split(',').map(int.parse).toList();

    return DataRow.byIndex(
      index: index,
      cells: [
        //Índice
        DataCell(Text('${index + 1}')),
        //FOTO
        const DataCell(CircleAvatar(
          backgroundColor: AppColors.amarilloPrincipal,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        )),
        //Nombres
        DataCell(Text(usuario.nombres)),
        //Apellidos
        DataCell(Text(usuario.apellidos)),
        //Correo
        DataCell(Text(usuario.correo)),
        //Grupos beneficiarios asociados
        DataCell(
          FutureBuilder(
              future: _getGruposNombres(listGruposBeneficiariosId, ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Error: No se pudieron obtener los grupos!!',
                      style: TextStyle(
                        color: AppColors.rojoPrincipal,
                      ),
                    ),
                  );
                }

                String nombresDeGrupos = snapshot.data!;
                return SingleChildScrollView(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 200,
                      minHeight: 50, // Establecer ancho máximo y altura mínima
                    ),
                    child: Text(
                      nombresDeGrupos,
                      softWrap: true,
                    ),
                  ),
                );
              }),
        ),
        //Rol
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: (usuario.rol == 'admin')
                  ? AppColors.azulPrincipal
                  : (usuario.rol == 'ejecutor')
                      ? AppColors.moradoSecundario
                      : (usuario.rol == 'ejecutor')
                          ? AppColors.verdePrincipal
                          : AppColors.amarilloPrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              usuario.rol,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        //Acciones
        DataCell(
          Row(
            children: [
              IconButton(
                tooltip: 'Borrar',
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: AppColors.rojoPrincipal,
                ),
                onPressed: () async {
                  await _deleteUsuarioModal(usuario);
                },
              ),
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.azulPrincipal,
                ),
                onPressed: () async {
                  await (User usuario) async {
                    bool res = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.5),
                      builder: (_) => Dialog(
                        elevation: 8,
                        backgroundColor: Colors.transparent,
                        child: UsuarioModal(
                          titulo: 'Editar',
                          modalPurpose: ModalPurpose.update,
                          user: usuario,
                        ),
                      ),
                    );

                    if (res) {
                      ref.read(usuariosManagerProvider.notifier).refresh();
                    }
                  }(usuario);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _deleteUsuarioModal(User usuario) async {
    bool res = await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        elevation: 8,
        backgroundColor: Colors.transparent,
        child: UsuarioModal(
          titulo: 'Borrar',
          modalPurpose: ModalPurpose.delete,
          user: usuario,
        ),
      ),
    );

    if (res) {
      ref.read(usuariosManagerProvider.notifier).refresh();
    }
  }
}

// Función auxiliar para obtener los nombres de los grupos beneficiarios
Future<String> _getGruposNombres(List<int> grupoIds, WidgetRef ref) async {
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
