import 'package:flutter/material.dart';

import '../screens/shopping_item_editor_screen.dart';
import '../widget/shopping_items_view.dart';
import '../widget/sharing_component.dart';
import '../constants.dart';
import '../models_providers/shopping_items_provider.dart';

class MainViewScreen extends StatefulWidget {
  @override
  _MainViewScreenState createState() => _MainViewScreenState();
}

class _MainViewScreenState extends State<MainViewScreen> {
  @override
  Widget build(BuildContext context) {
    final navState = Navigator.of(context);
    final shoppingItemList = dummyData;

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        leading: GestureDetector(
          child: IconButton(
            icon: Icon(Icons.mail),
            tooltip: "Click to add/update your address",
            onPressed: () => showMyAlert(context),
          ),
        ),
        title: Text(APP_TITLE_STRING),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              navState.pushNamed(ShoppingItemEditorScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: <Widget>[
          ...shoppingItemList
              .map((ShoppingItem shopItem) => ShoppingItemsViewWidget(shopItem))
              .toList(),
          const Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
          ),
          ShareComponentWidget(),
        ],
        //),
      ),
    );
  }
}
