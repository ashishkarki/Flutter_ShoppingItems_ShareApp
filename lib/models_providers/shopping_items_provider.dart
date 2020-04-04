import 'package:flutter/foundation.dart';
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

class ShoppingItemsProvider with ChangeNotifier {
  List<ShoppingItem> _items = [...dummyData];

  int get _serialNumber {
    // get a brand new serial no. for a new item being added
    return _items.length + 1;
  }

  List<ShoppingItem> get items {
    return [..._items];
  }

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

  void addNewShoppingItem(ShoppingItem newShoppingItem) {
    // generate new serialnumber before adding the new item
    newShoppingItem.serialNumber = _serialNumber;

    _items.add(newShoppingItem);
    // also, sort items according to the name
    sortShoppingItems();

    notifyListeners();
  }

  void updateShoppingItemUnits(int newShoppingItemWithUnitsOnly) {}

  void sortShoppingItems() {
    _items.sort(
      (item1, item2) => item1.name.compareTo(item2.name),
    );
  }
}
