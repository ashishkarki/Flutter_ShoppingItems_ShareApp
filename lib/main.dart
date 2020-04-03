import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models_providers/shopping_items_provider.dart';

import './screens/main-view-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ShoppingItemsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'some title',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainViewScreen(),
        routes: {},
      ),
    );
  }
}
