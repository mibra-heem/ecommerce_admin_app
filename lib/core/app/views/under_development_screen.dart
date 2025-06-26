

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ecommerce_admin_app/core/app/widgets/gradient_background.dart';
import 'package:ecommerce_admin_app/core/resources/media_res.dart';

class UnderDevelopmentScreen extends StatelessWidget {
  const UnderDevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Lottie.asset(MediaRes.underDevelopmentScreen),
              const Text(
                'Page Under Development',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
    );
  }
}
