import 'package:flutter/foundation.dart';
import '../constants.dart';

class ShoppingItem {
  final String name;
  final String description;
  final double quantity;
  final String unit;

  const ShoppingItem({
    @required this.name,
    @required this.description,
    @required this.quantity,
    @required this.unit,
  });
}

class ShoppingItemsProvider with ChangeNotifier {
  List<ShoppingItem> _items = [...dummyData];

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
}
