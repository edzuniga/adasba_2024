class Indicador {
  Indicador({
    this.id,
    required this.codaleaOrg,
    required this.codalea,
    required this.numeroIndicador,
    required this.tipoIndicador,
    required this.proyectoRelacionado,
    required this.componenteRelacionado,
    this.compromisoRelacionado,
    required this.nombreIndicador,
    required this.nombreCortoIndicador,
    this.descripcionIndicador,
    required this.c0,
    this.c1,
    this.c2,
    this.c3,
    this.c4,
    required this.c5,
    this.fuentesVerificacion,
    required this.activo,
    required this.fechaCreado,
    required this.creadoPor,
    this.fechaModi,
    this.modificadoPor,
  });

  final int? id;
  final String codaleaOrg;
  final String codalea;
  final String numeroIndicador;
  final int tipoIndicador;
  final int proyectoRelacionado;
  final int componenteRelacionado;
  final int? compromisoRelacionado;
  final String nombreIndicador;
  final String nombreCortoIndicador;
  final String? descripcionIndicador;
  final String c0;
  final String? c1;
  final String? c2;
  final String? c3;
  final String? c4;
  final String c5;
  final String? fuentesVerificacion;
  final int activo;
  final DateTime fechaCreado;
  final int creadoPor;
  final DateTime? fechaModi;
  final int? modificadoPor;
}
