import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models_providers/shopping_items_provider.dart';
import './models_providers/app_state_provider.dart';
import './models_providers/name_address_provider.dart';

import './screens/nameAddress_edit_screen.dart';
import './screens/nameAddress_view_screen.dart';
import './screens/shopping_list_screen.dart';
import 'screens/shopping_item_editor_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ShoppingItemsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AppStateProvider(),
        ),
        ChangeNotifierProvider.value(
          value: NameAddressProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'some title',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
        ),
        home: NameAddressViewScreen(),
        routes: {
          ShoppingListScreen.routeName: (ctx) => ShoppingListScreen(),
          ShoppingItemEditorScreen.routeName: (ctx) =>
              ShoppingItemEditorScreen(),
          NameAddressViewScreen.routeName: (ctx) => NameAddressViewScreen(),
          NameAddressEditScreen.routeName: (ctx) => NameAddressEditScreen(),
        },
      ),
    );
  }
}
