import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models_providers/shopping_items_provider.dart';

class ShoppingDropdown extends StatefulWidget {
  final List<String> _dropdownItems;
  final FocusNode _focusNode;
  ShoppingItem _editedShoppingItem;

  ShoppingDropdown(
    this._dropdownItems,
    this._focusNode,
    this._editedShoppingItem,
  );

  @override
  _ShoppingDropdownState createState() => _ShoppingDropdownState();
}

class _ShoppingDropdownState extends State<ShoppingDropdown> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      focusNode: widget._focusNode,
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey),
      underline: Container(
        height: 1,
        color: Colors.grey,
      ),
      hint: Text(
        'Select (Units)',
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;

          widget._editedShoppingItem = ShoppingItem(
            name: widget._editedShoppingItem.name,
            description: widget._editedShoppingItem.description,
            quantity: widget._editedShoppingItem.quantity,
            unit: newValue,
          );

          Provider.of<ShoppingItemsProvider>(context)
              .updateShoppingItemUnits(null);
        });
      },
      items: <String>[...widget._dropdownItems]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    ;
  }
}
