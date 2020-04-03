import 'package:flutter/material.dart';

import './models_providers/shopping_items_provider.dart';

const APP_TITLE_STRING = 'Type and Share App';
const SHARED_TEXT_SUBJECT_PREFIX =
    'Please deliver following items: (created using Ashish Karki\'s App)';

void showMyAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Alert Dialog title'),
      content: Text('Alert Dialog Body'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Close this?"),
        ),
      ],
    ),
  );
}

const List<ShoppingItem> dummyData = [
  ShoppingItem(
    serialNumber: 1,
    name: 'bread',
    description: 'Nanglo bread',
    quantity: 5.0,
    unit: 'packet',
  ),
  ShoppingItem(
    serialNumber: 2,
    name: 'soyabean oil',
    description: 'Swastik brand',
    quantity: 2.5,
    unit: 'litre',
  ),
  ShoppingItem(
    serialNumber: 3,
    name: 'Corn flakes',
    description: 'Kellog\'s brand',
    quantity: 2.0,
    unit: 'box',
  ),
  ShoppingItem(
    serialNumber: 4,
    name: 'Dettol liquid',
    description: 'Big bottle',
    quantity: 3.0,
    unit: 'bottle',
  ),
  ShoppingItem(
    serialNumber: 5,
    name: 'Chicken curry masala',
    description: 'Everest brand',
    quantity: 3.0,
    unit: 'packet',
  ),
  ShoppingItem(
    serialNumber: 6,
    name: 'Kurkure',
    description: 'Maggie',
    quantity: 4.0,
    unit: 'packet',
  ),
  ShoppingItem(
    serialNumber: 7,
    name: 'White wine',
    description: 'Sweet flavor - Nepali brand',
    quantity: 1.0,
    unit: 'bottle',
  ),
  ShoppingItem(
    serialNumber: 8,
    name: 'Pumpkin',
    description: 'Small green',
    quantity: 2.0,
    unit: 'kgs',
  ),
  ShoppingItem(
    serialNumber: 9,
    name: 'Bengal gram',
    description: 'Called Kalo chana',
    quantity: 700.0,
    unit: 'gram',
  ),
];
