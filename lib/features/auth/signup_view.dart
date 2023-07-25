import 'package:app/common/common.dart';
import 'package:app/constants/constants.dart';
import 'package:app/features/auth/auth_controller.dart';
import 'package:app/features/auth/auth_field.dart';
import 'package:app/features/auth/login_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/pallet.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const LoadingPage()
          : Center(
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
                          onTap: () {
                            onSignUp();
                          },
                          label: 'Sign up',
                          backgroundColor: Pallet.whiteColor,
                          textColor: Pallet.backgroundColor,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Already have an account?",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "  Login",
                                style: const TextStyle(
                                  color: Pallet.blueColor,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      LoginView.route(),
                                    );
                                  },
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
