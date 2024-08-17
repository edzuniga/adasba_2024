import 'package:adasba_2024/domain/entities/fuente.dart';

class FuenteModel extends Fuente {
  FuenteModel({
    super.id,
    required super.codaleaOrg,
    required super.codalea,
    required super.idProyecto,
    required super.codigoFuente,
    required super.nombreFuente,
    super.descripcionFuente,
    required super.activo,
    required super.fechaCreado,
    required super.creadoPor,
    super.fechaModi,
    super.modificadoPor,
  });

  factory FuenteModel.fromJson(Map<String, dynamic> json) => FuenteModel(
        id: json['id'] is int ? json['id'] : int.parse(json['id']),
        codaleaOrg: json['codalea_org'],
        codalea: json['codalea'],
        idProyecto: json['id_proyecto'] is int
            ? json['id_proyecto']
            : int.parse(json['id_proyecto']),
        codigoFuente: json['codigo_fuente'],
        nombreFuente: json['nombre_fuente'],
        descripcionFuente: json['descripcion_fuente'] ?? '',
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
        'codalea': codalea,
        'id_proyecto': idProyecto,
        'codigo_fuente': codigoFuente,
        'nombre_fuente': nombreFuente,
        'descripcion_fuente': descripcionFuente,
        'activo': activo,
        'fecha_creado': fechaCreado.toIso8601String(),
        'creado_por': creadoPor,
        'fecha_modi': fechaModi?.toIso8601String(),
        'modificado_por': modificadoPor,
      };

  FuenteModel copyWith({
    int? id,
    String? codaleaOrg,
    String? codalea,
    int? idProyecto,
    String? codigoFuente,
    String? nombreFuente,
    String? descripcionFuente,
    int? activo,
    DateTime? fechaCreado,
    int? creadoPor,
    DateTime? fechaModi,
    int? modificadoPor,
  }) =>
      FuenteModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        codalea: codalea ?? this.codalea,
        idProyecto: idProyecto ?? this.idProyecto,
        codigoFuente: codigoFuente ?? this.codigoFuente,
        nombreFuente: nombreFuente ?? this.nombreFuente,
        descripcionFuente: descripcionFuente ?? this.descripcionFuente,
        activo: activo ?? this.activo,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaModi: fechaModi ?? this.fechaModi,
        modificadoPor: modificadoPor ?? this.modificadoPor,
      );

  factory FuenteModel.fromFuente(Fuente fuente) => FuenteModel(
        id: fuente.id,
        codaleaOrg: fuente.codaleaOrg,
        codalea: fuente.codalea,
        idProyecto: fuente.idProyecto,
        codigoFuente: fuente.codigoFuente,
        nombreFuente: fuente.nombreFuente,
        descripcionFuente: fuente.descripcionFuente,
        activo: fuente.activo,
        fechaCreado: fuente.fechaCreado,
        creadoPor: fuente.creadoPor,
        fechaModi: fuente.fechaModi,
        modificadoPor: fuente.modificadoPor,
      );
}
