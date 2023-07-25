import 'package:app/constants/constants.dart';
import 'package:app/features/auth/auth_field.dart';
import 'package:app/features/auth/signup_view.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/common.dart';
import 'auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {

  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }


  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body:isLoading
          ? const LoadingPage()
          :  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(
                  controller: emailController,
                  hintText: 'email',
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthField(
                  controller: passwordController,
                  hintText: 'password',
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: onLogin,
                    label: 'login',
                    backgroundColor: Pallet.whiteColor,
                    textColor: Pallet.backgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    children: [
                      TextSpan(
                        text: "  Sign up",
                        style: const TextStyle(
                          color: Pallet.blueColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.push(
                            context,
                            SignUpView.route(),
                          );
                        },
                      ),
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
