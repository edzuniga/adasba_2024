import 'package:adasba_2024/domain/entities/actor.dart';

class ActorModel extends Actor {
  ActorModel({
    super.id,
    required super.codaleaOrg,
    required super.codalea,
    required super.nombre,
    required super.descripcion,
    required super.activo,
    required super.fechaCreado,
    required super.creadoPor,
    super.fechaModi,
    super.modificadoPor,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
        id: json['id'] is int ? json['id'] : int.parse(json['id']),
        codaleaOrg: json['codalea_org'],
        codalea: json['codalea'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
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
        'id': id,
        'codalea_org': codaleaOrg,
        'codalea': codalea,
        'nombre': nombre,
        'descripcion': descripcion,
        'activo': activo,
        'fecha_creado': fechaCreado.toIso8601String(),
        'creado_por': creadoPor,
        'fecha_modi': fechaModi?.toIso8601String(),
        'modificado_por': modificadoPor,
      };

  ActorModel copyWith({
    int? id,
    String? codaleaOrg,
    String? codalea,
    String? nombre,
    String? descripcion,
    int? activo,
    DateTime? fechaCreado,
    int? creadoPor,
    DateTime? fechaModi,
    int? modificadoPor,
  }) =>
      ActorModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        codalea: codalea ?? this.codalea,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        activo: activo ?? this.activo,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaModi: fechaModi ?? this.fechaModi,
        modificadoPor: modificadoPor ?? this.modificadoPor,
      );

  factory ActorModel.fromActor(Actor actor) => ActorModel(
        id: actor.id,
        codaleaOrg: actor.codaleaOrg,
        codalea: actor.codalea,
        nombre: actor.nombre,
        descripcion: actor.descripcion,
        activo: actor.activo,
        fechaCreado: actor.fechaCreado,
        creadoPor: actor.creadoPor,
        fechaModi: actor.fechaModi,
        modificadoPor: actor.modificadoPor,
      );
}
