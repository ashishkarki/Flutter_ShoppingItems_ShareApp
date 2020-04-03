import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../constants.dart';

class MainViewScreen extends StatefulWidget {
  @override
  _MainViewScreenState createState() => _MainViewScreenState();
}

class _MainViewScreenState extends State<MainViewScreen> {
  void _showMyAlert(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        leading: GestureDetector(
          child: IconButton(
            icon: Icon(Icons.mail),
            tooltip: "Click to add/update your address",
            onPressed: () => _showMyAlert(context),
          ),
        ),
        title: Text(APP_TITLE_STRING),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showMyAlert(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ...dummyData
                .map(
                  (ShareData data) => Card(
                    child: ListTile(
                      leading: Icon(Icons.arrow_forward),
                      title: Text(
                        data.name,
                        style: themeData.textTheme.title,
                      ),
                      subtitle: Text(data.description),
                      onTap: () => _showMyAlert(context),
                      trailing: Icon(Icons.delete),
                    ),
                  ),
                )
                .toList(),
            const Padding(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
            ),
            Builder(builder: (BuildContext context) {
              return RaisedButton(
                child: Text('Share'),
                onPressed: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(
                    'text',
                    subject: 'text subject',
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
