import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/resources/fonts.dart';
import 'package:ecommerce_admin_app/core/app/resources/media_res.dart';
import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/widgets/gradient_background.dart';
import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_admin_app/src/auth/presentation/screens/forms/forgot_password_form.dart';
import 'package:ecommerce_admin_app/src/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackbar(context, 'Error While forgot password');
          } else if (state is ForgotPasswordSent) {}
        },
        builder: (_, state) {
          return GradientBackground(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const Image(
                    height: 150,
                    width: 150,
                    image: AssetImage(MediaRes.appPurpleIcon),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Forgotten Password',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: Fonts.aeonik,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Provide your email and we will send you a link to '
                    'reset your password.',
                  ),
                  const SizedBox(height: 30),
                  ForgotPasswordForm(
                    formKey: formKey,
                    emailController: emailController,
                  ),
                  const SizedBox(height: 40),
                  RoundedButton(
                    'Reset Password',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          ForgotPasswordEvent(
                            email: emailController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  RoundedButton(
                    'Go back',
                    labelColor: Colours.primary,
                    buttonColor: Colours.white,
                    elevation: 0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) {
                            return BlocProvider(
                              create: (_) => sl<AuthBloc>(),
                              child: const SignInScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
