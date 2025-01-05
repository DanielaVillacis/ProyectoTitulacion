// 


import '../entities/user.dart';

abstract class AuthRepository {

  Future<User> login( String usuario, String contrasena );
  Future<User> register( String nombre, String apellido, String cargo, String? email, String contrasena );
  Future<User> checkAuthStatus( String token );

}