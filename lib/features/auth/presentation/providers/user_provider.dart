// import 'package:formulacionesctu/features/auth/domain/datasources/user_datasource.dart';
// import 'package:formulacionesctu/features/auth/domain/repositories/user_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:formulacionesctu/features/auth/domain/entities/user.dart';

// class UserProvider extends StateNotifier<User?> {
//   final UserRepository userRepository;

//   UserProvider(this.userRepository) : super(null);

//   Future<void> register(String nombre, String apellido, String cargo, String email, String usuario, String password) async {
//     final user = await userRepository.register(nombre, apellido, cargo, email, usuario, password);
//     if (user != null) {
//       state = user;
//     }
//   }
// }

// final userProvider = StateNotifierProvider<UserProvider, User?>((ref) {
//   final userDataSource = UserDataSource();
//   final userRepository = UserRepository(userDataSource);
//   return UserProvider(userRepository);
// });