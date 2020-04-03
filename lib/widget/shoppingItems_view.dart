import 'package:flutter/material.dart';

import '../constants.dart';
import '../models_providers/shopping_items_provider.dart';

class ShoppingItemsViewWidget extends StatelessWidget {
  final ShoppingItem _shoppingItem;

  ShoppingItemsViewWidget(this._shoppingItem);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      child: ListTile(
        leading: Text('${_shoppingItem.serialNumber}.'),
        title: Text(
          _shoppingItem.name,
          style: themeData.textTheme.title,
        ),
        subtitle: Text(_shoppingItem.description),
        trailing: Icon(Icons.delete),
        onTap: () => showMyAlert(context),
      ),
    );
  }
}
