import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_admin/views/sidebar/widgets/header_row.dart';
import 'package:smart_admin/views/sidebar/widgets/withdrawal_widget.dart';

class WithdrawalPage extends StatelessWidget {
  static const String route = 'withdrawal';

  const WithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Withdrawal',
              style: GoogleFonts.righteous(
                  fontSize: 36, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: const [
              HeaderRow(
                flex: 1,
                text: 'Name',
              ),
              HeaderRow(text: 'Bank Name', flex: 2),
              HeaderRow(text: 'Bank Account', flex: 2),
              HeaderRow(text: 'Account Number', flex: 2),
              HeaderRow(text: 'Phone', flex: 2),
              HeaderRow(text: 'Amount', flex: 1),
            ],
          ),
          const WithdrawalWidget()
        ],
      ),
    );
  }
}
