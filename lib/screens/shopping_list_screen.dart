import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../models_providers/name_address_provider.dart';
import '../widget/shopping_app_drawer.dart';
import '../constants.dart';
import '../models_providers/shopping_items_provider.dart';
import '../screens/shopping_item_editor_screen.dart';
import '../widget/shopping_item.dart';

class ShoppingListScreen extends StatelessWidget {
  static final routeName = '/shopping-list';

  void _deleteShoppingItem(
    ShoppingItemsProvider shoppingItemsProvider,
    ShoppingItem itemToDelete,
  ) {
    shoppingItemsProvider.deleteShoppingItem(itemToDelete);
  }

  void _updateShoppingItem(
    BuildContext context,
    ShoppingItemsProvider shoppingItemsProvider,
    ShoppingItem updatedItem,
  ) {
    Navigator.of(context).pushNamed(
      ShoppingItemEditorScreen.routeName,
      arguments: {
        'updatedItem': updatedItem,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final navState = Navigator.of(context);
    final themeData = Theme.of(context);
    final shopItemsProvider = Provider.of<ShoppingItemsProvider>(context);
    final nameAddProvider = Provider.of<NameAddressProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
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
      body: FutureBuilder(
        future: shopItemsProvider.items,
        builder: (
          BuildContext ctx,
          AsyncSnapshot<List<ShoppingItem>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(15.0),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext ctx, int itemIdx) {
              final currentShopItem = snapshot.data[itemIdx];
              return Container(
                color: Colors.amber[100],
                child: ShoppingItemWidget(
                  itemIdx + 1,
                  currentShopItem,
                  () => _updateShoppingItem(
                    context,
                    shopItemsProvider,
                    currentShopItem,
                  ),
                  () => _deleteShoppingItem(
                    shopItemsProvider,
                    currentShopItem,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final RenderBox box = context.findRenderObject();
          Share.share(
            '${nameAddProvider.formattedShareableText}\n${shopItemsProvider.formattedShareableText}',
            subject: SHARED_TEXT_SUBJECT_PREFIX,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
          );
        },
        label: Text('Share List'),
        backgroundColor: themeData.accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: ShoppingAppDrawer(),
    );
  }
}
