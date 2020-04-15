import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_items_share/models_providers/auth_provider.dart';
import 'package:shopping_items_share/screens/shopping_list_screen.dart';

import '../screens/nameAddress_view_screen.dart';

class ShoppingAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navState = Navigator.of(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Address/List Selector'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Name-Address'),
            subtitle: Text('View/Update Identity'),
            onTap: () => navState.pushReplacementNamed(
              NameAddressViewScreen.routeName,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Shopping-List'),
            subtitle: Text('View/Update List'),
            onTap: () => navState.pushReplacementNamed(
              ShoppingListScreen.routeName,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              navState.pop();
              navState.pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
