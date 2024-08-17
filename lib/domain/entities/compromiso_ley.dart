class CompromisoLey {
  CompromisoLey({
    this.id,
    required this.codaleaOrg,
    required this.codalea,
    required this.nombre,
    required this.descripcion,
    required this.activo,
    required this.fechaCreado,
    required this.creadoPor,
    this.fechaModi,
    this.modificadoPor,
  });

  final int? id;
  final String codaleaOrg;
  final String codalea;
  final String nombre;
  final String descripcion;
  final int activo;
  final DateTime fechaCreado;
  final int creadoPor;
  final DateTime? fechaModi;
  final int? modificadoPor;
}
