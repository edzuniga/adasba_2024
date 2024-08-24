class SetIndicador {
  SetIndicador({
    this.id,
    required this.codaleaOrg,
    required this.nombreSet,
    this.descripcionSet,
    required this.activo,
    required this.fechaCreado,
    required this.creadoPor,
    this.fechaModi,
    this.modificadoPor,
  });
  final int? id;
  final String codaleaOrg;
  final String nombreSet;
  final String? descripcionSet;
  final int activo;
  final DateTime fechaCreado;
  final int creadoPor;
  final DateTime? fechaModi;
  final int? modificadoPor;
}
