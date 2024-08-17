import 'package:adasba_2024/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.codaleaOrg,
    required super.codalea,
    super.foto,
    required super.correo,
    super.contrasena,
    required super.nombres,
    required super.apellidos,
    required super.rol,
    required super.activo,
    required super.creadoPor,
    required super.fechaCreado,
    super.modificadoPor,
    super.fechaModificado,
    required super.gruposBeneficiarios,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      codaleaOrg: json['codalea_org'],
      codalea: json['codalea'],
      foto: (json['foto'] != null) ? json['foto'] : null,
      correo: json['correo'],
      contrasena: (json['contrasena'] != null) ? json['contrasena'] : null,
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      rol: json['rol'].toString(),
      activo:
          json['activo'] is int ? json['activo'] : int.parse(json['activo']),
      creadoPor: json['creado_por'] is int
          ? json['creado_por']
          : int.parse(json['creado_por']),
      fechaCreado: DateTime.parse(json['fecha_creado']),
      modificadoPor: json['modificado_por'] != null
          ? (json['modificado_por'] is int
              ? json['modificado_por']
              : int.parse(json['modificado_por']))
          : null,
      fechaModificado:
          (json['fecha_modificado'] != null && json['fecha_modificado'] != '')
              ? DateTime.parse(json['fecha_modificado'])
              : null,
      gruposBeneficiarios: json['grupos_beneficiarios'],
    );
  }

  Map<String, dynamic> toJson() => {
        'codalea_org': codaleaOrg,
        'codalea': codalea,
        'foto': foto,
        'correo': correo,
        'contrasena': contrasena,
        'nombres': nombres,
        'apellidos': apellidos,
        'rol': rol,
        'activo': activo,
        'creado_por': creadoPor,
        'fecha_creado': fechaCreado.toIso8601String(),
        'modificado_por': modificadoPor,
        'fecha_modificado': fechaModificado?.toIso8601String(),
        'grupos_beneficiarios': gruposBeneficiarios,
      };

  UserModel copyWith({
    int? id,
    String? codaleaOrg,
    String? codalea,
    String? foto,
    String? correo,
    String? contrasena,
    String? nombres,
    String? apellidos,
    String? rol,
    int? activo,
    int? creadoPor,
    DateTime? fechaCreado,
    int? modificadoPor,
    DateTime? fechaModificado,
    String? gruposBeneficiarios,
  }) =>
      UserModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        codalea: codalea ?? this.codalea,
        foto: foto ?? this.foto,
        correo: correo ?? this.correo,
        contrasena: contrasena ?? this.contrasena,
        nombres: nombres ?? this.nombres,
        apellidos: apellidos ?? this.apellidos,
        rol: rol ?? this.rol,
        activo: activo ?? this.activo,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        modificadoPor: modificadoPor ?? this.modificadoPor,
        fechaModificado: fechaModificado ?? this.fechaModificado,
        gruposBeneficiarios: gruposBeneficiarios ?? this.gruposBeneficiarios,
      );

  factory UserModel.fromUser(User user) {
    return UserModel(
      codaleaOrg: user.codaleaOrg,
      codalea: user.codalea,
      foto: user.foto,
      correo: user.correo,
      contrasena: user.contrasena,
      nombres: user.nombres,
      apellidos: user.apellidos,
      rol: user.rol,
      activo: user.activo,
      creadoPor: user.creadoPor,
      fechaCreado: user.fechaCreado,
      modificadoPor: user.modificadoPor,
      fechaModificado: user.fechaModificado,
      gruposBeneficiarios: user.gruposBeneficiarios,
    );
  }
}
