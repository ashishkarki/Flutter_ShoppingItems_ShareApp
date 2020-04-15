import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_items_share/screens/nameAddress_edit_screen.dart';
import 'package:shopping_items_share/widget/shopping_app_drawer.dart';

import '../models_providers/name_address_provider.dart';

class NameAddressViewScreen extends StatelessWidget {
  static final routeName = '/name-address';

  @override
  Widget build(BuildContext context) {
    final NameAddressProvider nameAddressProvider =
        Provider.of<NameAddressProvider>(context);

    return FutureBuilder(
      builder: (context, AsyncSnapshot<NameAddress> snapshot) {
        if (snapshot.hasData) {
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
                    Navigator.of(context)
                        .pushNamed(NameAddressEditScreen.routeName);
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
                      snapshot.data.firstName,
                    ),
                    subtitle: Text(
                      'First Name',
                    ),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.middleName,
                    ),
                    subtitle: Text(
                      'Middle Name',
                    ),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.lastName,
                    ),
                    subtitle: Text(
                      'Last Name',
                    ),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.street,
                    ),
                    subtitle: Text('Street'),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.city,
                    ),
                    subtitle: Text('City'),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.stateOrProvince,
                    ),
                    subtitle: Text('Street/Province Name'),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.nearestLandmark,
                    ),
                    subtitle: Text('Nearest Landmark'),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.contactPhone1,
                    ),
                    subtitle: Text('Contact 1'),
                    dense: true,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data.contactPhone2,
                    ),
                    subtitle: Text('Contact 2(if available)'),
                    dense: true,
                  ),
                ],
              ).toList(),
            ),
            drawer: ShoppingAppDrawer(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: nameAddressProvider.item,
    );
  }
}
