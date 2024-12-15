import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;

  const CustomScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1920,
          child: child,
        ),
      ),
    );
  }
}
