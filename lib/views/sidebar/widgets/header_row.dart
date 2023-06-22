import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    Key? key,
    required this.text,
    required this.flex,
  }) : super(key: key);
  final String text;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 169, 167, 166)),
            color: Colors.yellow.shade900),
        child: Align(
          alignment: const Alignment(0, 0),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.righteous(
                letterSpacing: 1, color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
