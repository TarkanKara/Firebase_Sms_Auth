part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthCodeSent extends AuthState {}

class AuthCodeVerified extends AuthState {}

class AuthLoggedIn extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {}

class SwitchUpdated extends AuthState {}

class AuthComplated extends AuthState {}
