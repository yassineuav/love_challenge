import 'package:app/apis/auth_api.dart';
import 'package:app/apis/user_api.dart';
import 'package:app/core/utils.dart';
import 'package:app/features/home/home_view.dart';
import 'package:app/models/user_model.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserAccountProvider = FutureProvider((ref) {
  return ref.watch(authControllerProvider.notifier).currentUser();
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});


class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userApi;

  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userApi = userAPI,
        super(false);

  Future<model.Account?> currentUser() => _authAPI.currentUserAccount();


  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        UserModel userModel = UserModel(
            email: email,
            name: getNameFromEmail(email),
            followers: [],
            following: [],
            profilePic: '',
            bannerPic: '',
            uid: r.$id,
            bio: '',
            isTwitterBlue: false);
        // Navigator.push(context, LoginView.route());
        showSnackBar(context, "Account created successfully!");

        final result = await _userApi.saveUserData(userModel);
        result.fold((l) {
          showSnackBar(context, "ERROR when Saving user data ...");
        }, (r) {
          showSnackBar(context, "user data saved ...");
          autoLogin(context, email, password);
        });

        // auto redirect user to home page
      },
    );
  }

  void autoLogin(context, email, password) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, "Login in...\nRedirecting to Home page ...");
        Navigator.push(context, HomeView.route());
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
        showSnackBar(context,
            "Account created successfully!\nRedirecting to Home page ...");
        Navigator.push(context, HomeView.route());
      },
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userApi.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
