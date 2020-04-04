import 'package:flutter/material.dart';

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
            onTap: () => navState.pushReplacementNamed('/'),
          ),
        ],
      ),
    );
  }
}
