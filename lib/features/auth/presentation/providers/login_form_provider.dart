import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:formulacionesctu/features/auth/presentation/providers/auth_provider.dart';
import 'package:formulacionesctu/features/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier,LoginFormState>((ref) {

  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;


  return LoginFormNotifier(
    loginUserCallback:loginUserCallback
  );
});


//! 2 - Como implementamos un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function(String, String) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }): super( LoginFormState() );
  
  onUsuarioChange( String value ) {
    final newUsuario = Usuario.dirty(value);
    state = state.copyWith(
      usuario: newUsuario,
      isValid: Formz.validate([ newUsuario, state.contrasena ])
    );
  }

  onPasswordChanged( String value ) {
    final newContrasena = Password.dirty(value);
    state = state.copyWith(
      contrasena: newContrasena ,
      isValid: Formz.validate([ newContrasena , state.usuario ])
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if ( !state.isValid ) return;

    state = state.copyWith(isPosting: true);

    await loginUserCallback( state.usuario.value, state.contrasena.value );

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {

    final usuario    = Usuario.dirty(state.usuario.value);
    final contrasena = Password.dirty(state.contrasena.value);

    state = state.copyWith(
      isFormPosted: true,
      usuario: usuario,
      contrasena: contrasena,
      isValid: Formz.validate([ usuario, contrasena ])
    );

  }

}


//! 1 - State del provider
class LoginFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Usuario usuario;
  final Password contrasena;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.usuario = const Usuario.pure(),
    this.contrasena = const Password.pure()
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Usuario? usuario,
    Password? contrasena,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    usuario: usuario ?? this.usuario,
    contrasena: contrasena ?? this.contrasena,
  );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    usuario: $usuario
    contrasena: $contrasena
''';
  }
}
