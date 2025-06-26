import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce_admin_app/core/resources/media_res.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      context.goNamed(RouteName.initial);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colours.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(MediaRes.appIcon),
              height: 150,
              width: 150,
            ),
            Text(
              'ecommerce_admin_app',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
