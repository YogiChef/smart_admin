import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  static const String route = 'dashboard';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          'Dashboard',
          style:
              GoogleFonts.righteous(fontSize: 36, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
