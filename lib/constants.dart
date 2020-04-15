import 'package:flutter/material.dart';

import './models_providers/shopping_items_provider.dart';

const APP_TITLE_STRING = 'Type and Share App';

const SHARED_TEXT_SUBJECT_PREFIX =
    'Please deliver following items: (created using Ashish Karki\'s App)';

const SHOPPING_ITEM_UNIT_NAMEs = [
  'Kilogram',
  'Grams',
  'Litre',
  'Millilitre',
  'Packet',
  'Bag',
  'Box',
  'Can',
  'Bottle',
  'Piece',
  'Other-general Unit'
];

const SHARED_PREF_NAME_ADDRESS_STRING = 'userNameAddress';
const SHARED_PREF_SHOPPING_ITEMS_STRING = 'userShoppingItems';
const SHARED_PREF_USER_AUTH_STRING = 'userAuthData';

enum AuthMode { Signup, Login }

const FIREBASE_WEB_API_KEY = 'AIzaSyDOehFkuM0xzoJFVa-nTompSpeKOhf1KkY';
const FIREBASE_WEB_SERVER_URL = 'https://flutter-update-53d45.firebaseio.com/';
const FIREBASE_EMAIL_PW_SIGNUP_URL =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';
const FIREBASE_EMAIL_PW_LOGIN_URL =
    'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=';
const FIREBASE_DB_PRODUCTS_SUFFIX = '/products';
const FIREBASE_DB_ORDERS_SUFFIX = '/orders';
const REST_REQUEST_ERROR_TITLE = 'Error occured during REST request';

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

final List<ShoppingItem> dummyData = [
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
