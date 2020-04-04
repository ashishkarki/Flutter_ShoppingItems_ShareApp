import 'package:flutter/material.dart';

import '../models_providers/shopping_items_provider.dart';

class ShoppingItemWidget extends StatelessWidget {
  final int itemViewIndex;
  final ShoppingItem _shoppingItem;
  final Function _updateShoppingItem;
  final Function _deleteShoppingItem;

  ShoppingItemWidget(
    this.itemViewIndex,
    this._shoppingItem,
    this._updateShoppingItem,
    this._deleteShoppingItem,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        leading: Text('$itemViewIndex.'),
        title: Text(
          _shoppingItem.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: _updateShoppingItem,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteShoppingItem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
