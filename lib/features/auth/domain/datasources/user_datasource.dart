
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:formulacionesctu/features/auth/infrastructure/mappers/user_mapper.dart';

// class UserDataSource {
//   Future<UserModel?> register(String nombre, String apellido, String cargo, String email, String usuario, String password) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:5049/api/WantUsuario/registrar'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'nombre': nombre,
//         'apellido': apellido,
//         'cargo': cargo,
//         'email': email,
//         'usuario': usuario,
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