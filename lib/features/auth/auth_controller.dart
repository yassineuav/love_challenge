import 'package:app/apis/auth_api.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/auth/login_view.dart';
import 'package:app/features/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
  );
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

  // isLoading
  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        //showSnackBar(context, "Account created! please login in");
        // Navigator.push(context, LoginView.route());
        // auto redirect user to home page
        _authAPI.login(email: email, password: password);
      },
    );
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, "Account created successfully!\nRedirecting to Home page ...");
        Navigator.push(context, HomeView.route());},
    );
  }
}
