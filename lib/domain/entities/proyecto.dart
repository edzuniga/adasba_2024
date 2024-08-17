class Proyecto {
  Proyecto({
    this.id,
    required this.codaleaOrg,
    required this.codalea,
    required this.nombreProyecto,
    required this.nombreCorto,
    required this.descripcion,
    required this.gruposRelacionados,
    required this.activo,
    required this.fechaCreado,
    required this.creadoPor,
    this.fechaModi,
    this.modificadoPor,
  });

  final int? id;
  final String codaleaOrg;
  final String codalea;
  final String nombreProyecto;
  final String nombreCorto;
  final String descripcion;
  final String gruposRelacionados;
  final int activo;
  final DateTime fechaCreado;
  final int creadoPor;
  final DateTime? fechaModi;
  final int? modificadoPor;
}
