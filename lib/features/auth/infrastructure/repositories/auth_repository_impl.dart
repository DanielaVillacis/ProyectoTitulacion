

import 'package:formulacionesctu/features/auth/domain/domain.dart';
import '../infrastructure.dart';


class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String usuario, String contrasena) {
    return dataSource.login(usuario, contrasena);
  }

  @override
  Future<User> register(String nombre, String apellido, String cargo, String? email, String contrasena) {
    return dataSource.register(nombre, apellido, cargo, email, contrasena);
  }

}