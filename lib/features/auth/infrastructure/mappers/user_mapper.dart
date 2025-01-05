// import 'package:formulacionesctu/features/auth/domain/entities/user.dart';

// class UserMapper extends User {
//   UserMapper({
//     required int id,
//     required String nombre,
//     required String apellido,
//     required String cargo,
//     required String email,
//     required String usuario,
//     String? token,
//   }) : super(
//           id: id,
//           nombre: nombre,
//           apellido: apellido,
//           cargo: cargo,
//           email: email,
//           usuario: usuario,
//           token: token,
//         );

//   factory UserMapper.fromJson(Map<String, dynamic> json) {
//     return UserMapper(
//       id: json['id'],
//       nombre: json['nombre'],
//       apellido: json['apellido'],
//       cargo: json['cargo'],
//       email: json['email'],
//       usuario: json['usuario'],
//       token: json['token'],
//     );
//   }
// }



import 'package:formulacionesctu/features/auth/domain/domain.dart';


class UserMapper {


  static User userJsonToEntity( Map<String,dynamic> json ) => User(
   
    id: json['id'],
    nombre: json['nombre'],
    apellido: json['apellido'],
    cargo: json['cargo'],
    email: json['email'],
    usuario: json['usuario'],
    token: json['token'] ?? '',
     // roles: List<String>.from(json['roles'].map( (role) => role )),
  );

}
