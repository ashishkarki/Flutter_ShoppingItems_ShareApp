import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../constants.dart';
import '../models_providers/shopping_items_provider.dart';

class ShareComponentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final shopItemsProvider = Provider.of<ShoppingItemsProvider>(context);

    return Builder(
      builder: (BuildContext context) {
        return RaisedButton(
          color: themeData.accentColor,
          child: Text(
            'Click to Share List',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {
            final RenderBox box = context.findRenderObject();
            Share.share(
              shopItemsProvider.formattedShareableText,
              subject: SHARED_TEXT_SUBJECT_PREFIX,
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
            );
          },
        );
      },
    );
  }
}
