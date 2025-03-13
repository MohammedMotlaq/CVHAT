import 'dart:ui';

import 'package:flutter/material.dart';

class LoaderBlurScreen extends StatelessWidget {
  const LoaderBlurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(children: [
        // Blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            color: Colors.white.withOpacity(0.1), // Optional dimming
          ),
        ),
        // Loading Indicator
        const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading...",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        )
      ]),
    );
  }
}
