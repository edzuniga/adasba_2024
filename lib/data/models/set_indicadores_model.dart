import 'package:adasba_2024/domain/entities/set_indicador.dart';

class SetIndicadoresModel extends SetIndicador {
  SetIndicadoresModel({
    super.id,
    required super.codaleaOrg,
    required super.nombreSet,
    super.descripcionSet,
    required super.activo,
    required super.fechaCreado,
    required super.creadoPor,
    super.fechaModi,
    super.modificadoPor,
  });

  factory SetIndicadoresModel.fromJson(Map<String, dynamic> json) =>
      SetIndicadoresModel(
        id: json['id'] is int ? json['id'] : int.parse(json['id']),
        codaleaOrg: json['codalea_org'],
        nombreSet: json['nombre_set'],
        descripcionSet: json['descripcion_set'],
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

  Map<String, dynamic> toJson() => {
        'codalea_org': codaleaOrg,
        'nombre_set': nombreSet,
        'descripcion_set': descripcionSet,
        'activo': activo,
        'fecha_creado': fechaCreado.toIso8601String(),
        'creado_por': creadoPor,
        'fecha_modi': fechaModi?.toIso8601String(),
        'modificado_por': modificadoPor,
      };

  SetIndicadoresModel copyWith({
    int? id,
    String? codaleaOrg,
    String? nombreSet,
    String? descripcionSet,
    int? activo,
    DateTime? fechaCreado,
    int? creadoPor,
    DateTime? fechaModi,
    int? modificadoPor,
  }) =>
      SetIndicadoresModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        nombreSet: nombreSet ?? this.nombreSet,
        descripcionSet: descripcionSet ?? this.descripcionSet,
        activo: activo ?? this.activo,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaModi: fechaModi ?? this.fechaModi,
        modificadoPor: modificadoPor ?? this.modificadoPor,
      );

  factory SetIndicadoresModel.fromSetIndicador(SetIndicador setIndicador) =>
      SetIndicadoresModel(
        id: setIndicador.id,
        codaleaOrg: setIndicador.codaleaOrg,
        nombreSet: setIndicador.nombreSet,
        descripcionSet: setIndicador.descripcionSet,
        activo: setIndicador.activo,
        fechaCreado: setIndicador.fechaCreado,
        creadoPor: setIndicador.creadoPor,
        fechaModi: setIndicador.fechaModi,
        modificadoPor: setIndicador.modificadoPor,
      );
}
