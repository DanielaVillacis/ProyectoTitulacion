// import 'package:formulacionesctu/features/auth/domain/datasources/auth_datasource.dart';
// import 'package:formulacionesctu/features/auth/domain/repositories/auth_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:formulacionesctu/features/auth/domain/entities/user.dart';


// class AuthProvider extends StateNotifier<User?> {
//   final AuthRepository authRepository;

//   AuthProvider(this.authRepository) : super(null);

//   Future<void> login(String username, String password) async {
//     final user = await authRepository.login(username, password);
//     if (user != null) {
//       state = user;
//     }
//   }

//   void logout() {
//     state = null;
//   }
// }

// final authProvider = StateNotifierProvider<AuthProvider, User?>((ref) {
//   final authDataSource = AuthDataSource();
//   final authRepository = AuthRepository(authDataSource);
//   return AuthProvider(authRepository);
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formulacionesctu/features/auth/domain/domain.dart';
import 'package:formulacionesctu/features/auth/infrastructure/infrastructure.dart';
import 'package:formulacionesctu/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:formulacionesctu/features/shared/infrastructure/services/key_value_storage_service_impl.dart';


final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();


  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});



class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super( AuthState() ) {
    checkAuthStatus();
  }
  

  Future<void> loginUser( String usuario, String contrasena ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(usuario, contrasena);
      _setLoggedUser( user );

    } on CustomError catch (e) {
      logout( e.message );
    } catch (e){
      logout(e.toString());
          
    }

    

    // final user = await authRepository.login(email, password);
    // state =state.copyWith(user: user, authStatus: AuthStatus.authenticated)

  }

  void registerUser( String usuario, String password ) async {
    //TODO: IMPLEMENTAR
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if( token == null ) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);

    } catch (e) {
      logout();
    }

  }

  void _setLoggedUser( User user ) async {
    
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([ String? errorMessage ]) async {
    
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }

}



enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );




}