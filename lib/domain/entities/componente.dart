class Componente {
  Componente({
    this.id,
    required this.codaleaOrg,
    required this.codalea,
    required this.idProyecto,
    required this.nombreComponente,
    this.descripcionComponente,
    required this.codigoComponente,
    required this.activo,
    required this.fechaCreado,
    required this.creadoPor,
    this.fechaModi,
    this.modificadoPor,
  });

  final int? id;
  final String codaleaOrg;
  final String codalea;
  final int idProyecto;
  final String nombreComponente;
  final String? descripcionComponente;
  final String codigoComponente;
  final int activo;
  final DateTime fechaCreado;
  final int creadoPor;
  final DateTime? fechaModi;
  final int? modificadoPor;
}
