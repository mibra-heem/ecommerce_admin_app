import 'dart:ui';

import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:flutter/material.dart';

class BlurredLoadingView extends StatelessWidget {
  const BlurredLoadingView({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(180),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colours.primary),
              ),
            ),
            const SizedBox(height: 16),
            Text(label ?? '', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
