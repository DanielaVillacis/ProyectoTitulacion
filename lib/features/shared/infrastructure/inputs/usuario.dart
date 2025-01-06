import 'package:formz/formz.dart';

// Define input validation errors
enum UsuarioError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Usuario extends FormzInput<String, UsuarioError> {

 
  static final RegExp _userRegExp = RegExp(
    r'^[a-zA-Z0-9]+$');

  // Call super.pure to represent an unmodified form input.
  const Usuario.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Usuario.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == UsuarioError.empty ) return 'El campo es requerido';
    if ( displayError == UsuarioError.format ) return 'No debe contener caracteres especiales';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UsuarioError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return UsuarioError.empty;
    if ( !_userRegExp.hasMatch(value) ) return UsuarioError.format;

    return null;
  }
}