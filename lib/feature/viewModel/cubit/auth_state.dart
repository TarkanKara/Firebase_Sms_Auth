part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthCodeSent extends AuthState {}

class SwitchUpdated extends AuthState {}

class OtpCodeUpdated extends AuthState {}
