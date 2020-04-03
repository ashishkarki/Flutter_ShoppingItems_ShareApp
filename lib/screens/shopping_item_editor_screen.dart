import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models_providers/shopping_items_provider.dart';
import '../widget/shopping_dropdown.dart';
import '../models_providers/app_state_provider.dart';
import '../constants.dart';

class ShoppingItemEditorScreen extends StatelessWidget {
  static final routeName = '/shopping-item-editor';

  final _formKey = GlobalKey<FormState>();
  var _editedShoppingItem = ShoppingItem(
    name: '',
    description: '',
    quantity: 0.0,
    unit: '',
  );
  var _initShoppingItemValues = {
    'name': '',
    'description': '',
    'quantity': 0.0,
    'unit': '',
  };

  void _saveForm(
    BuildContext context,
    AppStateProvider appStateProvider,
    ShoppingItemsProvider shoppingItemsProvider,
  ) {
    if (_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    appStateProvider.isLoading = true;

    try {
      shoppingItemsProvider.sortShoppingItems();
    } catch (exception) {
      print(exception);
    } finally {
      appStateProvider.isLoading = false;
    }

    Navigator.of(context).pop();
  }

  final _descriptionFocusNode = FocusNode();
  final _quantityFocusNode = FocusNode();
  final _unitFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);
    final appStateProvider = Provider.of<AppStateProvider>(context);
    final shopItemsProvider = Provider.of<ShoppingItemsProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit new Item'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(
              context,
              appStateProvider,
              shopItemsProvider,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // // ITEM NAME
                TextFormField(
                  initialValue: _initShoppingItemValues['name'],
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Name for the item';
                    }
                    return null;
                  },
                ),
                // // ITEM DESCRIPTION
                TextFormField(
                  initialValue: _initShoppingItemValues['description'],
                  decoration: InputDecoration(
                    labelText:
                        'Item Description like brand, color, material etc',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_quantityFocusNode);
                  },
                ),
                // // ITEM QUANITY
                TextFormField(
                  initialValue: _initShoppingItemValues['quantity'],
                  decoration: InputDecoration(
                    labelText: 'Quantity in Units',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  maxLines: 3,
                  focusNode: _quantityFocusNode,
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_unitFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a numerical Quantity for the item';
                    }
                    if (double.parse(value) <= 0.0) {
                      return 'Please enter a numerical value greater than Zero';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                  ),
                ),
                // // ITEM UNIT/s like Kgs, Litre, Packets, Bag, Box, Grams, Can etc
                ShoppingDropdown(SHOPPING_ITEM_UNIT_NAMEs, _unitFocusNode),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () => _saveForm(
                      context,
                      appStateProvider,
                      shopItemsProvider,
                    ),
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
