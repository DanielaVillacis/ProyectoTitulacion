// import 'package:http/http.dart' as http;

// import 'dart:convert';
// import 'package:formulacionesctu/features/auth/infraestructure/models/user_model.dart';

// class AuthDataSource {
//   Future<UserModel?> login(String username, String password) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:5049/api/WantUsuario/validar'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': username,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return UserModel.fromJson(jsonDecode(response.body));
//     } else {
//       return null;
//     }
//   }
// }

import '../entities/user.dart';

abstract class AuthDataSource {

  Future<User> login( String usuario, String contrasena );
  Future<User> register(String nombre, String apellido, String cargo, String? email, String contrasena );
  Future<User> checkAuthStatus( String token );

}

