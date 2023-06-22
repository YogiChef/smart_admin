import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_admin/views/sidebar/widgets/vendor_widget.dart';
import 'widgets/header_row.dart';

class VendorsPage extends StatelessWidget {
  static const String route = 'vendors';

  const VendorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Manage Vendors',
              style: GoogleFonts.righteous(
                  fontSize: 36, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: const [
              HeaderRow(
                flex: 1,
                text: 'Logo',
              ),
              HeaderRow(text: 'Bussiness Name', flex: 3),
              HeaderRow(text: 'City', flex: 2),
              HeaderRow(text: 'State', flex: 2),
              HeaderRow(text: 'Action', flex: 1),
              HeaderRow(text: 'View More', flex: 1),
            ],
          ),
          const VendorWidget()
        ],
      ),
    );
  }
}
