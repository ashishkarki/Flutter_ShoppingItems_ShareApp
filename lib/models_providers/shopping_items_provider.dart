import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_items_share/abstract/shopping_output.dart';

import '../constants.dart';

class ShoppingItem {
  int serialNumber;
  final String name;
  final String description;
  final double quantity;
  final String unit;

  ShoppingItem({
    this.serialNumber = 0,
    @required this.name,
    @required this.description,
    @required this.quantity,
    @required this.unit,
  });
}

class ShoppingItemsProvider
    with ChangeNotifier
    implements AbstractShoppingOutput {
  List<ShoppingItem> _items = [];

  int get _serialNumber {
    // get a brand new serial no. for a new item being added
    return _items.length + 1;
  }

  Future<List<ShoppingItem>> get items async {
    final sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.containsKey(SHARED_PREF_SHOPPING_ITEMS_STRING) &&
        sharedPref.getStringList(SHARED_PREF_SHOPPING_ITEMS_STRING) != null) {
      // clear _items
      _items = [];
      final List<String> savedShoppingItems =
          sharedPref.getStringList(SHARED_PREF_SHOPPING_ITEMS_STRING);
      savedShoppingItems.forEach(
        (String shopItemString) {
          final decodedShopItemStr =
              jsonDecode(shopItemString) as Map<String, Object>;
          //print('decodedShopItemStr: $decodedShopItemStr');
          _items.add(
            ShoppingItem(
              serialNumber: decodedShopItemStr['serialNumber'],
              name: decodedShopItemStr['name'],
              description: decodedShopItemStr['description'],
              unit: decodedShopItemStr['unit'],
              quantity: decodedShopItemStr['quantity'],
            ),
          );
        },
      );
    }

    return [..._items];
  }

  @override
  String get formattedShareableText {
    var itemIndex = 0;
    var formatShareText = '';

    _items.forEach((shopItem) {
      final String eachLine =
          '${++itemIndex}. ${shopItem.name} (${shopItem.description}), Qty: ${shopItem.quantity} ${shopItem.unit}';

      formatShareText += eachLine + '\n';
    });

    return formatShareText;
  }

  Future<void> addNewShoppingItem(ShoppingItem newShoppingItem) async {
    try {
      // generate new serialnumber before adding the new item
      newShoppingItem.serialNumber = _serialNumber;

      _items.add(newShoppingItem);
      // also, sort items according to the name
      sortShoppingItems();

      notifyListeners();

      final sharedPref = await SharedPreferences.getInstance();
      List<String> userShoppingItems = [];
      _items.forEach((ShoppingItem shopItem) {
        userShoppingItems.add(
          jsonEncode(
            {
              'serialNumber': shopItem.serialNumber,
              'name': shopItem.name,
              'description': shopItem.description,
              'quantity': shopItem.quantity,
              'unit': shopItem.unit,
            },
          ),
        );
      });

      sharedPref.setStringList(
        SHARED_PREF_SHOPPING_ITEMS_STRING,
        userShoppingItems,
      );
    } on Exception catch (exception) {
      print('some errror during addNewShoppingItem: $exception');
      throw exception;
    }
  }

  void deleteShoppingItem(ShoppingItem itemToDelete) {
    _items.remove(itemToDelete);

    notifyListeners();
  }

  void updateShoppingItem(ShoppingItem updatedItem) {
    final idToUpdate = updatedItem.serialNumber;
    // final indexOfIdToUpdate = _items.indexWhere((shopItem) => shopItem.serialNumber == idToUpdate);

    _items.removeWhere((shopItem) => shopItem.serialNumber == idToUpdate);
    _items.add(updatedItem);

    sortShoppingItems();

    notifyListeners();
  }

  void sortShoppingItems() {
    _items.sort(
      (item1, item2) => item1.name.compareTo(
        item2.name,
      ),
    );
  }
}
