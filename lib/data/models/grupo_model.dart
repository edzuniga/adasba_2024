import 'package:adasba_2024/domain/entities/grupo_beneficiario.dart';

class GrupoModel extends Grupo {
  GrupoModel({
    super.id,
    required super.codaleaOrg,
    required super.codalea,
    required super.nombre,
    required super.lugar,
    super.descripcion,
    required super.activo,
    required super.fechaCreado,
    required super.creadoPor,
    super.fechaModi,
    super.modificadoPor,
  });

  factory GrupoModel.fromJson(Map<String, dynamic> json) {
    return GrupoModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      codaleaOrg: json['codalea_org'],
      codalea: json['codalea'],
      nombre: json['nombre'],
      lugar: json['lugar'],
      descripcion: json['descripcion'],
      activo:
          json['activo'] is int ? json['activo'] : int.parse(json['activo']),
      fechaCreado: DateTime.parse(json['fecha_creado']),
      creadoPor: json['creado_por'] is int
          ? json['creado_por']
          : int.parse(json['creado_por']),
      fechaModi: (json['fecha_modi'] != null && json['fecha_modi'] != '')
          ? DateTime.parse(json['fecha_modi'])
          : null,
      modificadoPor: json['modificado_por'] != null
          ? (json['modificado_por'] is int
              ? json['modificado_por']
              : int.parse(json['modificado_por']))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'codalea_org': codaleaOrg,
        'codalea': codalea,
        'nombre': nombre,
        'lugar': lugar,
        'descripcion': descripcion,
        'activo': activo,
        'fecha_creado': fechaCreado.toIso8601String(),
        'creado_por': creadoPor,
        'fecha_modi': fechaModi?.toIso8601String(),
        'modificado_por': modificadoPor,
      };

  GrupoModel copyWith({
    int? id,
    String? codaleaOrg,
    String? codalea,
    String? nombre,
    String? lugar,
    String? descripcion,
    int? activo,
    DateTime? fechaCreado,
    int? creadoPor,
    DateTime? fechaModi,
    int? modificadoPor,
  }) =>
      GrupoModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        codalea: codalea ?? this.codalea,
        nombre: nombre ?? this.nombre,
        lugar: lugar ?? this.lugar,
        descripcion: descripcion ?? this.descripcion,
        activo: activo ?? this.activo,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaModi: fechaModi ?? this.fechaModi,
        modificadoPor: modificadoPor ?? this.modificadoPor,
      );

  factory GrupoModel.fromGrupo(Grupo grupo) {
    return GrupoModel(
      codaleaOrg: grupo.codaleaOrg,
      codalea: grupo.codalea,
      nombre: grupo.nombre,
      lugar: grupo.lugar,
      descripcion: grupo.descripcion ?? '',
      activo: grupo.activo,
      fechaCreado: grupo.fechaCreado,
      creadoPor: grupo.creadoPor,
      fechaModi: grupo.fechaModi,
      modificadoPor: grupo.modificadoPor,
    );
  }
}
