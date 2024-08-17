import 'package:adasba_2024/domain/entities/proyecto.dart';

class ProyectoModel extends Proyecto {
  ProyectoModel({
    super.id,
    required super.codaleaOrg,
    required super.codalea,
    required super.nombreProyecto,
    required super.nombreCorto,
    required super.descripcion,
    required super.gruposRelacionados,
    required super.activo,
    required super.fechaCreado,
    required super.creadoPor,
    super.fechaModi,
    super.modificadoPor,
  });

  factory ProyectoModel.fromJson(Map<String, dynamic> json) {
    return ProyectoModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      codaleaOrg: json['codalea_org'],
      codalea: json['codalea'],
      nombreProyecto: json['nombre_proyecto'],
      nombreCorto: json['nombre_corto'],
      descripcion: json['descripcion'],
      gruposRelacionados: json['grupos_relacionados'],
      activo: json['activo'],
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
        'nombre_proyecto': nombreProyecto,
        'nombre_corto': nombreCorto,
        'descripcion': descripcion,
        'grupos_relacionados': gruposRelacionados,
        'activo': activo,
        'fecha_creado': fechaCreado.toIso8601String(),
        'creado_por': creadoPor,
        'fecha_modi': fechaModi?.toIso8601String(),
        'modificado_por': modificadoPor,
      };

  ProyectoModel copyWith({
    int? id,
    String? codaleaOrg,
    String? codalea,
    String? nombreProyecto,
    String? nombreCorto,
    String? descripcion,
    String? gruposRelacionados,
    int? activo,
    DateTime? fechaCreado,
    int? creadoPor,
    DateTime? fechaModi,
    int? modificadoPor,
  }) =>
      ProyectoModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        codalea: codalea ?? this.codalea,
        nombreProyecto: nombreProyecto ?? this.nombreProyecto,
        nombreCorto: nombreCorto ?? this.nombreCorto,
        descripcion: descripcion ?? this.descripcion,
        gruposRelacionados: gruposRelacionados ?? this.gruposRelacionados,
        activo: activo ?? this.activo,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaModi: fechaModi ?? this.fechaModi,
        modificadoPor: modificadoPor ?? this.modificadoPor,
      );

  factory ProyectoModel.fromProyecto(Proyecto proyecto) {
    return ProyectoModel(
      id: proyecto.id,
      codaleaOrg: proyecto.codaleaOrg,
      codalea: proyecto.codalea,
      nombreProyecto: proyecto.nombreProyecto,
      nombreCorto: proyecto.nombreCorto,
      descripcion: proyecto.descripcion,
      gruposRelacionados: proyecto.gruposRelacionados,
      activo: proyecto.activo,
      fechaCreado: proyecto.fechaCreado,
      creadoPor: proyecto.creadoPor,
      fechaModi: proyecto.fechaModi,
      modificadoPor: proyecto.modificadoPor,
    );
  }
}
