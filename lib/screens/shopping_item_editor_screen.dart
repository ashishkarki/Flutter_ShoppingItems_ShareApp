import 'package:flutter/material.dart';

class ShoppingItemEditorScreen extends StatelessWidget {
  static final routeName = '/shopping-item-editor';

  final _formKey = GlobalKey<FormState>();

  void _saveForm(BuildContext context) {
    Navigator.of(context).pop();
  }

  final _descriptionFocusNode = FocusNode();
  final _quantityFocusNode = FocusNode();
  final _unitFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit new Item'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(context),
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
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_descriptionFocusNode);
                  },
                ),
                // // ITEM DESCRIPTION
                TextFormField(
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
                  decoration: InputDecoration(
                    labelText: 'Quantity in Units',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _quantityFocusNode,
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_unitFocusNode);
                  },
                ),
                // // ITEM UNIT/s like Kgs, Litre, Packets, Bag, Box, Grams, Can etc
              ],
            ),
          ),
        ),
      ),
    );
  }
}
