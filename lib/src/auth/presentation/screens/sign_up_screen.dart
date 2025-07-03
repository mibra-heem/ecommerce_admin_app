import 'package:ecommerce_admin_app/core/app/providers/user_provider.dart';
import 'package:ecommerce_admin_app/core/app/resources/fonts.dart';
import 'package:ecommerce_admin_app/core/app/resources/media_res.dart';
import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/widgets/gradient_background.dart';
import 'package:ecommerce_admin_app/core/app/widgets/rounded_button.dart';
import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_admin_app/src/auth/presentation/screens/forms/sign_up_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackbar(context, state.message);
          } else if (state is SignedUp) {
            if (kDebugMode) print('Entered SignedUp State...');
            context.read<AuthBloc>().add(
              SignInEvent(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              ),
            );
          } else if (state is SignedIn) {
            debugPrint('SignedIn state and User is : ${state.user}');
            sl<UserProvider>().cacheUserData(state.user);
            context.goNamed(RouteName.initial, extra: state.user);
          }
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
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: Fonts.aeonik,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SignUpForm(
                    formKey: formKey,
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  const SizedBox(height: 40),
                  if (state is AuthLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    RoundedButton(
                      'Create',
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // FirebaseAuth.instance.currentUser?.reload();
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignUpEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          minimumSize: WidgetStatePropertyAll(Size.zero),
                        ),
                        onPressed: () {
                          context.pushReplacementNamed(RouteName.signIn);
                        },
                        child: const Text('Log In'),
                      ),
                    ],
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
