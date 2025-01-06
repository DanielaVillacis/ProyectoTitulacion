class User {
  final int id;
  final String nombre;
  final String apellido;
  final String cargo;
  final String? email;
  final String usuario;
 final String token; //token puede ser nulo para usuarios que se registran

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.cargo,
    this.email,
    required this.usuario,
    required this.token,
  });

   bool get isAdmin {
    return cargo.contains('administrador');
  }





}
