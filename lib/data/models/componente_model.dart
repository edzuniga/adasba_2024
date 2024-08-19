import 'package:adasba_2024/domain/entities/componente.dart';

class ComponenteModel extends Componente {
  ComponenteModel({
    super.id,
    required super.codaleaOrg,
    required super.codalea,
    required super.idProyecto,
    required super.nombreComponente,
    super.descripcionComponente,
    required super.codigoComponente,
    required super.activo,
    required super.fechaCreado,
    required super.creadoPor,
    super.fechaModi,
    super.modificadoPor,
  });

  factory ComponenteModel.fromJson(Map<String, dynamic> json) {
    return ComponenteModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      codaleaOrg: json['codalea_org'],
      codalea: json['codalea'],
      idProyecto: json['id_proyecto'],
      nombreComponente: json['nombre_componente'],
      descripcionComponente: json['descripcion_componente'],
      codigoComponente: json['codigo_componente'],
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
        'id_proyecto': idProyecto,
        'nombre_componente': nombreComponente,
        'descripcion_componente': descripcionComponente,
        'codigo_componente': codigoComponente,
        'activo': activo,
        'fecha_creado': fechaCreado.toIso8601String(),
        'creado_por': creadoPor,
        'fecha_modi': fechaModi?.toIso8601String(),
        'modificado_por': modificadoPor,
      };

  ComponenteModel copyWith({
    int? id,
    String? codaleaOrg,
    String? codalea,
    int? idProyecto,
    String? nombreComponente,
    String? descripcionComponente,
    String? codigoComponente,
    int? activo,
    DateTime? fechaCreado,
    int? creadoPor,
    DateTime? fechaModi,
    int? modificadoPor,
  }) =>
      ComponenteModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        codalea: codalea ?? this.codalea,
        idProyecto: idProyecto ?? this.idProyecto,
        nombreComponente: nombreComponente ?? this.nombreComponente,
        descripcionComponente:
            descripcionComponente ?? this.descripcionComponente,
        codigoComponente: codigoComponente ?? this.codigoComponente,
        activo: activo ?? this.activo,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaModi: fechaModi ?? this.fechaModi,
        modificadoPor: modificadoPor ?? this.modificadoPor,
      );

  factory ComponenteModel.fromComponente(Componente componente) {
    return ComponenteModel(
      id: componente.id,
      codaleaOrg: componente.codaleaOrg,
      codalea: componente.codalea,
      idProyecto: componente.idProyecto,
      nombreComponente: componente.nombreComponente,
      descripcionComponente: componente.descripcionComponente,
      codigoComponente: componente.codigoComponente,
      activo: componente.activo,
      fechaCreado: componente.fechaCreado,
      creadoPor: componente.creadoPor,
      fechaModi: componente.fechaModi,
      modificadoPor: componente.modificadoPor,
    );
  }
}
