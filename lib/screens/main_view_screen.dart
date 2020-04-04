import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shopping_items_share/widget/shopping_app_drawer.dart';

import '../constants.dart';
import '../models_providers/shopping_items_provider.dart';
import '../screens/shopping_item_editor_screen.dart';
import '../widget/shopping_items_view.dart';

class MainViewScreen extends StatefulWidget {
  @override
  _MainViewScreenState createState() => _MainViewScreenState();
}

class _MainViewScreenState extends State<MainViewScreen> {
  @override
  Widget build(BuildContext context) {
    final navState = Navigator.of(context);
    final themeData = Theme.of(context);
    final shopItemsProvider = Provider.of<ShoppingItemsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        // leading: GestureDetector(
        //   child: IconButton(
        //     icon: Icon(Icons.mail),
        //     tooltip: "Click to add/update your address",
        //     onPressed: () => showMyAlert(context),
        //   ),
        // ),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: shopItemsProvider.items.length,
        itemBuilder: (BuildContext ctx, int itemIdx) {
          return Container(
            color: Colors.amber[100],
            child: ShoppingItemsViewWidget(
              itemIdx + 1,
              shopItemsProvider.items[itemIdx],
            ),
          );
        },
      ),
      // children: <Widget>[
      //   ...shopItemsProvider.items
      //       .map(
      //         (ShoppingItem shoppingItem) => ShoppingItemsViewWidget(
      //           shoppingItem,
      //         ),
      //       )
      //       .toList(),
      // const Padding(
      //   padding: EdgeInsets.only(
      //     top: 20.0,
      //   ),
      // ),
      // ShareComponentWidget(),
      //],
      //),
      //),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final RenderBox box = context.findRenderObject();
          Share.share(
            shopItemsProvider.formattedShareableText,
            subject: SHARED_TEXT_SUBJECT_PREFIX,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
          );
        },
        label: Text('Share this List'),
        backgroundColor: themeData.accentColor,
      ),
      drawer: ShoppingAppDrawer(),
    );
  }
}
