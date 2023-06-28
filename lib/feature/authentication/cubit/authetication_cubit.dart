import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peacemaker/feature/authentication/cubit/authetication_state.dart';
import 'package:peacemaker/feature/authentication/repository/authentication_repository.dart';

class AutheticationCubit extends Cubit<AutheticationState> {
  AutheticationCubit(super.initialState);
  Locale locale = const Locale("en");

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  Future<void> registerUser(
      String emailAddress, String password, String username) async {
    emit(AutheticationRegisterLoading(
        const Center(child: CircularProgressIndicator())));
    final UserCredential? credential = await _authenticationRepository
        .registeruser(emailAddress, password, username);

    if (credential == null) {
      emit(AutheticationRegisterError('Please check the fields.'));
    } else if (credential.user?.uid != null) {
      emit(AutheticationRegisterSuccess(credential));
    }
  }

  // User login using firebase.
  Future<void> loginUser(String email, String password) async {
    final UserCredential? credential =
        await _authenticationRepository.loginUser(email, password);

    if (credential == null) {
      // Fluttertoast.showToast(msg: '');
      emit(AuthenticationLoginError('Please try again!'));
    } else {
      emit(AuthenticationLoginSuccess(credential));
    }
  }

  Future<void> logoutUser() async {
    emit(AuthenticationLogoutLoading());
    await FirebaseAuth.instance.signOut();
  }

  Locale? changeLocale(BuildContext context, String langCode) {
    EasyLocalization.of(context)?.setLocale(Locale(langCode));
    locale = Locale(langCode);

    emit(LocalizationChange());

    return locale;
  }
}
