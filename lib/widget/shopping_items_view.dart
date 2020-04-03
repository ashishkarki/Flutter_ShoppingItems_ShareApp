import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models_providers/app_state_provider.dart';
import '../constants.dart';
import '../models_providers/shopping_items_provider.dart';

class ShoppingItemsViewWidget extends StatelessWidget {
  final int itemViewIndex;
  final ShoppingItem _shoppingItem;

  ShoppingItemsViewWidget(this.itemViewIndex, this._shoppingItem);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      child: ListTile(
        leading: Text('$itemViewIndex.'),
        title: Text(
          _shoppingItem.name,
          style: themeData.textTheme.title,
        ),
        subtitle: Text(
          '${_shoppingItem.description}, Qty: ${_shoppingItem.quantity} ${_shoppingItem.unit}',
          softWrap: true,
          overflow: TextOverflow.clip,
        ),
        trailing: Icon(Icons.delete),
        onTap: () => showMyAlert(context),
      ),
    );
  }
}
