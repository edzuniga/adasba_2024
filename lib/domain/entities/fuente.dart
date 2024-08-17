class Fuente {
  Fuente({
    this.id,
    required this.codaleaOrg,
    required this.codalea,
    required this.idProyecto,
    required this.codigoFuente,
    required this.nombreFuente,
    this.descripcionFuente,
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
  final String codigoFuente;
  final String nombreFuente;
  final String? descripcionFuente;
  final int activo;
  final DateTime fechaCreado;
  final int creadoPor;
  final DateTime? fechaModi;
  final int? modificadoPor;
}
