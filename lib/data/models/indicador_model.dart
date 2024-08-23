import 'package:adasba_2024/domain/entities/indicador.dart';

class IndicadorModel extends Indicador {
  IndicadorModel({
    super.id,
    required super.codaleaOrg,
    required super.codalea,
    required super.numeroIndicador,
    required super.tipoIndicador,
    required super.proyectoRelacionado,
    required super.componenteRelacionado,
    super.compromisoRelacionado,
    required super.nombreIndicador,
    required super.nombreCortoIndicador,
    super.descripcionIndicador,
    required super.c0,
    super.c1,
    super.c2,
    super.c3,
    super.c4,
    required super.c5,
    super.fuentesVerificacion,
    required super.activo,
    required super.fechaCreado,
    required super.creadoPor,
    super.fechaModi,
    super.modificadoPor,
  });

  factory IndicadorModel.fromJson(Map<String, dynamic> json) {
    return IndicadorModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      codaleaOrg: json['codalea_org'],
      codalea: json['codalea'],
      numeroIndicador: json['numero_indicador'],
      tipoIndicador: json['tipo_indicador'],
      proyectoRelacionado: json['proyecto_relacionado'],
      componenteRelacionado: json['componente_relacionado'],
      compromisoRelacionado: json['compromiso_relacionado'],
      nombreIndicador: json['nombre_indicador'],
      nombreCortoIndicador: json['nombre_corto_indicador'],
      descripcionIndicador: json['descripcion_indicador'],
      c0: json['c0'],
      c1: json['c1'],
      c2: json['c2'],
      c3: json['c3'],
      c4: json['c4'],
      c5: json['c5'],
      fuentesVerificacion: json['fuentes_verificacion'],
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
        'numero_indicador': numeroIndicador,
        'tipo_indicador': tipoIndicador,
        'proyecto_relacionado': proyectoRelacionado,
        'componente_relacionado': componenteRelacionado,
        'compromiso_relacionado': compromisoRelacionado,
        'nombre_indicador': nombreIndicador,
        'nombre_corto_indicador': nombreCortoIndicador,
        'descripcion_indicador': descripcionIndicador,
        'c0': c0,
        'c1': c1,
        'c2': c2,
        'c3': c3,
        'c4': c4,
        'c5': c5,
        'fuentes_verificacion': fuentesVerificacion,
        'activo': activo,
        'fecha_creado': fechaCreado.toIso8601String(),
        'creado_por': creadoPor,
        'fecha_modi': fechaModi?.toIso8601String(),
        'modificado_por': modificadoPor,
      };

  IndicadorModel copyWith({
    int? id,
    String? codaleaOrg,
    String? codalea,
    String? numeroIndicador,
    int? tipoIndicador,
    int? proyectoRelacionado,
    int? componenteRelacionado,
    int? compromisoRelacionado,
    String? nombreIndicador,
    String? nombreCortoIndicador,
    String? descripcionIndicador,
    String? c0,
    String? c1,
    String? c2,
    String? c3,
    String? c4,
    String? c5,
    String? fuentesVerificacion,
    int? activo,
    DateTime? fechaCreado,
    int? creadoPor,
    DateTime? fechaModi,
    int? modificadoPor,
  }) =>
      IndicadorModel(
        id: id ?? this.id,
        codaleaOrg: codaleaOrg ?? this.codaleaOrg,
        codalea: codalea ?? this.codalea,
        numeroIndicador: numeroIndicador ?? this.numeroIndicador,
        tipoIndicador: tipoIndicador ?? this.tipoIndicador,
        proyectoRelacionado: proyectoRelacionado ?? this.proyectoRelacionado,
        componenteRelacionado:
            componenteRelacionado ?? this.componenteRelacionado,
        compromisoRelacionado:
            compromisoRelacionado ?? this.compromisoRelacionado,
        nombreIndicador: nombreIndicador ?? this.nombreIndicador,
        nombreCortoIndicador: nombreCortoIndicador ?? this.nombreCortoIndicador,
        descripcionIndicador: descripcionIndicador ?? this.descripcionIndicador,
        c0: c0 ?? this.c0,
        c1: c1 ?? this.c1,
        c2: c2 ?? this.c2,
        c3: c3 ?? this.c3,
        c4: c4 ?? this.c4,
        c5: c5 ?? this.c5,
        fuentesVerificacion: fuentesVerificacion ?? this.fuentesVerificacion,
        activo: activo ?? this.activo,
        fechaCreado: fechaCreado ?? this.fechaCreado,
        creadoPor: creadoPor ?? this.creadoPor,
        fechaModi: fechaModi ?? this.fechaModi,
        modificadoPor: modificadoPor ?? this.modificadoPor,
      );

  factory IndicadorModel.fromIndicador(Indicador indicador) {
    return IndicadorModel(
      id: indicador.id,
      codaleaOrg: indicador.codaleaOrg,
      codalea: indicador.codalea,
      numeroIndicador: indicador.numeroIndicador,
      tipoIndicador: indicador.tipoIndicador,
      proyectoRelacionado: indicador.proyectoRelacionado,
      componenteRelacionado: indicador.componenteRelacionado,
      compromisoRelacionado: indicador.compromisoRelacionado,
      nombreIndicador: indicador.nombreIndicador,
      nombreCortoIndicador: indicador.nombreCortoIndicador,
      descripcionIndicador: indicador.descripcionIndicador,
      c0: indicador.c0,
      c1: indicador.c1,
      c2: indicador.c2,
      c3: indicador.c3,
      c4: indicador.c4,
      c5: indicador.c5,
      fuentesVerificacion: indicador.fuentesVerificacion,
      activo: indicador.activo,
      fechaCreado: indicador.fechaCreado,
      creadoPor: indicador.creadoPor,
      fechaModi: indicador.fechaModi,
      modificadoPor: indicador.modificadoPor,
    );
  }

  @override
  String toString() {
    return '''
IndicadorModel {
  id: $id,
  codaleaOrg: $codaleaOrg,
  codalea: $codalea,
  numeroIndicador: $numeroIndicador,
  tipoIndicador: $tipoIndicador,
  proyectoRelacionado: $proyectoRelacionado,
  componenteRelacionado: $componenteRelacionado,
  compromisoRelacionado: $compromisoRelacionado,
  nombreIndicador: $nombreIndicador,
  nombreCortoIndicador: $nombreCortoIndicador,
  descripcionIndicador: $descripcionIndicador,
  c0: $c0,
  c1: $c1,
  c2: $c2,
  c3: $c3,
  c4: $c4,
  c5: $c5,
  fuentesVerificacion: $fuentesVerificacion,
  activo: $activo,
  fechaCreado: $fechaCreado,
  creadoPor: $creadoPor,
  fechaModi: $fechaModi,
  modificadoPor: $modificadoPor
}
''';
  }
}
