import 'dart:ui';

import 'package:flutter/material.dart';

class LoaderBlurScreen extends StatelessWidget {
  const LoaderBlurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
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
