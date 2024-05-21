import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mult_shop_admin/views/side_bar_screens/buyers_screen.dart';
import 'package:mult_shop_admin/views/side_bar_screens/categories_screen.dart';
import 'package:mult_shop_admin/views/side_bar_screens/orders_screen.dart';
import 'package:mult_shop_admin/views/side_bar_screens/products_screen.dart';
import 'package:mult_shop_admin/views/side_bar_screens/upload_banners_screen.dart';
import 'package:mult_shop_admin/views/side_bar_screens/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();
  screenSelector(item) {
    switch (item.route) {
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });
        break;

      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });

        break;

      case ProductsScreen.id:
        setState(() {
          _selectedScreen = ProductsScreen();
        });

        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = OrdersScreen();
        });

        break;
      case CategoriesScreen.id:
        setState(() {
          _selectedScreen = CategoriesScreen();
        });

        break;
      case UploadBannersScreen.id:
        setState(() {
          _selectedScreen = UploadBannersScreen();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Management'),
      ),
      body: _selectedScreen,
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyersScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrdersScreen.id,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoriesScreen.id,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            route: UploadBannersScreen.id,
            icon: Icons.upload_file,
          ),
          AdminMenuItem(
            title: 'Products',
            route: ProductsScreen.id,
            icon: Icons.store,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
      ),
    );
  }
}
