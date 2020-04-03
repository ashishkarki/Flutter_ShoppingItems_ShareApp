import 'package:flutter/material.dart';

class ShoppingItemEditorScreen extends StatelessWidget {
  static final routeName = '/shopping-item-editor';

  final _formKey = GlobalKey<FormState>();

  void _saveForm(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
