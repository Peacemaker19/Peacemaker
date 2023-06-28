import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

abstract class AutheticationState {}

class AutheticationInitial extends AutheticationState {}

class AutheticationRegisterLoading extends AutheticationState {
  Widget widget;
  AutheticationRegisterLoading(this.widget);
}

class AutheticationRegisterSuccess extends AutheticationState {
  UserCredential credential;

  AutheticationRegisterSuccess(this.credential);
}

class AutheticationRegisterError extends AutheticationState {
  final String msg;
  AutheticationRegisterError(this.msg);
}

class AuthenticationLoginSuccess extends AutheticationState {
  UserCredential credential;

  AuthenticationLoginSuccess(this.credential);
}

class AuthenticationLoginLoading extends AutheticationState {}

class AuthenticationLoginError extends AutheticationState {
  final String msg;
  AuthenticationLoginError(this.msg);
}

class AuthenticationLogoutError extends AutheticationState {
  final String msg;
  AuthenticationLogoutError(this.msg);
}

class AuthenticationLogoutSuccess extends AutheticationState {}

class AuthenticationLogoutLoading extends AutheticationState {}

class LocalizationChange extends AutheticationState {}
