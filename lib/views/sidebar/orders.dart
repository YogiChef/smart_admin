import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_admin/views/sidebar/widgets/orders_widget.dart';

import 'widgets/header_row.dart';

class OrdersPage extends StatelessWidget {
  static const String route = 'orders';

  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Orders',
              style:
                  GoogleFonts.righteous(fontSize: 36, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: const [
              HeaderRow(flex: 1, text: 'Image',),
              HeaderRow(text: 'Product Name', flex: 3),
              HeaderRow(text: 'Cutommer Name', flex: 2),
              HeaderRow(text: 'Address', flex: 2),
              HeaderRow(text: 'Action', flex: 1),
              HeaderRow(text: 'View More', flex: 1),
            ],
          ),
          const OrderWidget(),
        ],
      ),);
  }
}
