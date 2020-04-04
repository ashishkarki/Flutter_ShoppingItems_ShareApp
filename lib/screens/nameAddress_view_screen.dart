import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_items_share/screens/nameAddress_edit_screen.dart';
import 'package:shopping_items_share/widget/shopping_app_drawer.dart';

import '../models_providers/name_address_provider.dart';

class NameAddressViewScreen extends StatelessWidget {
  static final routeName = '/name-address';

  @override
  Widget build(BuildContext context) {
    final NameAddressProvider nameAddProvider =
        Provider.of<NameAddressProvider>(context);
    final NameAddress nameAddressItem = nameAddProvider.item;
    final navState = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View/Update Name-Address',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit_location),
            onPressed: () {
              navState.pushNamed(NameAddressEditScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text(
                nameAddressItem.firstName,
              ),
              subtitle: Text(
                'First Name',
              ),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.middleName,
              ),
              subtitle: Text(
                'Middle Name',
              ),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.lastName,
              ),
              subtitle: Text(
                'Last Name',
              ),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.street,
              ),
              subtitle: Text('Street'),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.city,
              ),
              subtitle: Text('City'),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.stateOrProvince,
              ),
              subtitle: Text('Street/Province Name'),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.nearestLandmark,
              ),
              subtitle: Text('Nearest Landmark'),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.contactPhone1,
              ),
              subtitle: Text('Contact 1'),
              dense: true,
            ),
            ListTile(
              title: Text(
                nameAddressItem.contactPhone2,
              ),
              subtitle: Text('Contact 2(if available)'),
              dense: true,
            ),
          ],
        ).toList(),
      ),
      drawer: ShoppingAppDrawer(),
    );
  }
}
