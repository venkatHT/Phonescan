import 'package:flutter/material.dart';

class DocDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.picture_as_pdf),
          title: Text("My Documents"),
        ),
        ListTile(
          leading: Icon(Icons.merge_type),
          title: Text("Merge Documents"),
        ),
        ListTile(
          leading: Icon(Icons.call_split),
          title: Text("Split Documents"),
        ),

        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("About this App"),
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text("Share this App"),
        )
      ],
    );
  }
}
