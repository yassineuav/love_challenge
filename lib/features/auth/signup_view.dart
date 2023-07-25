import 'package:app/common/rounded_small_button.dart';
import 'package:app/constants/constants.dart';
import 'package:app/features/auth/auth_field.dart';
import 'package:app/features/auth/login_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../theme/pallet.dart';


class SignUpView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
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
                    onTap: () {},
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
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(
                              context,
                              LoginView.route(),
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
