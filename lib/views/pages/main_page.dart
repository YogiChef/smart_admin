// ignore_for_file: no_duplicate_case_values

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_admin/views/sidebar/dashboard.dart';
import 'package:smart_admin/views/sidebar/orders.dart';
import 'package:smart_admin/views/sidebar/product.dart';
import 'package:smart_admin/views/sidebar/upload_banner.dart';
import 'package:smart_admin/views/sidebar/vendors.dart';
import 'package:smart_admin/views/sidebar/withdrawal.dart';

import '../sidebar/categories.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _selectItem = const DashboardPage();

  pageSelector(item) {
    switch (item.route) {
      case DashboardPage.route:
        setState(() {
          _selectItem = const DashboardPage();
        });
        break;
      case DashboardPage.route:
        setState(() {
          _selectItem = const DashboardPage();
        });
        break;
      case VendorsPage.route:
        setState(() {
          _selectItem = const VendorsPage();
        });
        break;
      case WithdrawalPage.route:
        setState(() {
          _selectItem = const WithdrawalPage();
        });
        break;
      case CategoriesPage.route:
        setState(() {
          _selectItem = const CategoriesPage();
        });
        break;
      case OrdersPage.route:
        setState(() {
          _selectItem = const OrdersPage();
        });
        break;
      case ProductsPage.route:
        setState(() {
          _selectItem = const ProductsPage();
        });
        break;
      case UploadBannerPage.route:
        setState(() {
          _selectItem = const UploadBannerPage();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          title: Text(
            'Management',
            style: GoogleFonts.righteous(color: Colors.white, fontSize: 22),
          )),
      sideBar: SideBar(
        textStyle: GoogleFonts.righteous(
          fontSize: 16,
        ),
        activeBackgroundColor: Colors.yellow.shade900,
       
        items: const [
          AdminMenuItem(
              title: 'Dashboard',
              icon: Icons.dashboard,
              route: DashboardPage.route),
          AdminMenuItem(
              title: 'Vendors',
              icon: CupertinoIcons.person_3,
              route: VendorsPage.route),
          AdminMenuItem(
              title: 'WithDrawal',
              icon: CupertinoIcons.money_dollar,
              route: WithdrawalPage.route),
          AdminMenuItem(
              title: 'Categories',
              icon: Icons.category,
              route: CategoriesPage.route),
          AdminMenuItem(
              title: 'Orders',
              icon: CupertinoIcons.shopping_cart,
              route: OrdersPage.route),
          AdminMenuItem(
              title: 'Products', icon: Icons.shop, route: ProductsPage.route),
          AdminMenuItem(
              title: 'Upload Banner',
              icon: Icons.upload,
              route: UploadBannerPage.route),
        ],
        selectedRoute: '',
        onSelected: ((item) => pageSelector(item)),
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: Center(
            child: Text(
              'Smart Store Panel',
              style: GoogleFonts.righteous(color: Colors.white),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: Center(
            child: Text(
              'Smart Store Panel',
              style: GoogleFonts.righteous(color: Colors.white),
            ),
          ),
        ),
      ),
      body: _selectItem,
    );
  }
}
