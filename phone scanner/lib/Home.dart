import 'dart:async';

import 'package:PhoneScanner/sfg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'dart:io';


import 'NewImage.dart';
import 'Providers/documentProvider.dart';
import 'Search.dart';
import 'Sfc.dart';

import 'pdfScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MethodChannel channel = MethodChannel('opencv');
  File _file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Phone Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: Search());
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      body:  Container(
        child: Center(
          child: Text(
            "After creating pdf, the pdf will be displayed in                            (/Internal storage/Phone Scanner/)",
            textAlign: TextAlign.center,
          ),
        ),
      ),


      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Text('Camera'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Sfc()),
                  );
                },
              ),
              Container(
                color: Colors.white.withOpacity(0.2),
                width: 2,
                height: 15,
              ),
              FlatButton(
                child: Text('Import from gallery'),
                textColor: Colors.white,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Sfg ()),
                  );
                },
              ),

            ],
          )),


    );
  }
}

