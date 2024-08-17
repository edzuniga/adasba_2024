class User {
  User({
    this.id,
    required this.codaleaOrg,
    required this.codalea,
    this.foto,
    required this.correo,
    this.contrasena,
    required this.nombres,
    required this.apellidos,
    required this.rol,
    required this.activo,
    required this.creadoPor,
    required this.fechaCreado,
    this.modificadoPor,
    this.fechaModificado,
    required this.gruposBeneficiarios,
  });

  final int? id;
  final String codaleaOrg;
  final String codalea;
  final String? foto;
  final String correo;
  final String? contrasena;
  final String nombres;
  final String apellidos;
  final String rol;
  final int activo;
  final int creadoPor;
  final DateTime fechaCreado;
  final int? modificadoPor;
  final DateTime? fechaModificado;
  final String gruposBeneficiarios;

  @override
  String toString() {
    return 'id: $id codaleaOrg: $codaleaOrg codalea: $codalea foto: $foto correo: $correo contrasena: $contrasena nombres: $nombres apellidos: $apellidos rol: $rol activo: $activo creadoPor: $creadoPor fechaCreado: $fechaCreado modificadoPor: $modificadoPor fechaModificado: $fechaModificado gruposBeneficiarios: $gruposBeneficiarios';
  }
}
