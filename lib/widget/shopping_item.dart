import 'package:flutter/material.dart';

import '../constants.dart';
import '../models_providers/shopping_items_provider.dart';

class ShoppingItemWidget extends StatelessWidget {
  final int itemViewIndex;
  final ShoppingItem _shoppingItem;

  ShoppingItemWidget(this.itemViewIndex, this._shoppingItem);

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
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
