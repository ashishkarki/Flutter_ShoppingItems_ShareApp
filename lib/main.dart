import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models_providers/shopping_items_provider.dart';
import './models_providers/app_state_provider.dart';

import './screens/main_view_screen.dart';
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
      ],
      child: MaterialApp(
        title: 'some title',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
        ),
        home: MainViewScreen(),
        routes: {
          ShoppingItemEditorScreen.routeName: (ctx) =>
              ShoppingItemEditorScreen(),
        },
      ),
    );
  }
}
