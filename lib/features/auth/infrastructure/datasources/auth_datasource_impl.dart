import 'package:dio/dio.dart';
import 'package:formulacionesctu/config/config.dart';
import 'package:formulacionesctu/features/auth/domain/domain.dart';
import 'package:formulacionesctu/features/auth/infrastructure/infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<User> checkAuthStatus(String token) async {
    
    try {
      
      final response = await dio.get('/WantUsuario/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;


    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError('Token incorrecto');
      }
      if( e.response?.statusCode == 500 ){
         throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<User> login(String usuario, String contrasena) async {
    
    try {
      final response = await dio.post('/WantUsuario/validar', data: {
        'usuario': usuario,
        'contrasena': contrasena
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }


  }

  @override
  Future<User> register(String nombre, String apellido, String cargo, String? email, String contrasena) async {
    // TODO: implement register
   try {
      final response = await dio.post('/WantUsuario/registrar', data: {
        'nombre': nombre,
        'apellido': apellido,
        'cargo' : cargo,
        'email' : email ?? '',
        'contrasena': contrasena
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 500 ){
         throw CustomError(e.response?.data['message'] ?? 'Falla con el servidor' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
  
}
