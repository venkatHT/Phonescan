import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw ;

import 'package:pdf/widgets.dart' as pw ;
import 'package:path/path.dart' as path;

import 'package:flutter/services.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:provider/provider.dart';

import 'NewImage.dart';
import 'Providers/documentProvider.dart';


class Sfg extends StatefulWidget {
  File file;
  var imagePixelSize;
  double width;
  double height;
  Offset tl, tr, bl, br;
  GlobalKey<AnimatedListState> animatedListKey;

  @override
  _SfgState createState() => _SfgState();
}

class _SfgState extends State<Sfg> {
  TextEditingController nameController = TextEditingController();
  final _focusNode = FocusNode();
  MethodChannel channel = new MethodChannel('opencv');
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int index = 0;
  bool isBottomOpened = false;
  PersistentBottomSheetController controller;
  var whiteboardBytes;
  var originalBytes;
  var grayBytes;
  bool isGrayBytes = false;
  bool isOriginalBytes = false;
  bool isWhiteBoardBytes = false;
  bool isRotating = false;
  int angle = 0;
  List<Asset> images = List<Asset>();
  List<File> imgFile = List<File>();
  List<dynamic> img = [];
  final pdf = pw.Document();
  int i=0;
  bool _visible = false;
  static GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  void _toggle(int i){
    setState(() {
      this.i = i;
      _visible = !_visible;
    });
  }

  void delItem(){
    setState(() {
      images.removeAt(i);
    });
  }

  void navToShow(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewImage(imgFile[i], animatedListKey)))
    ;
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#424242",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      images.forEach((imageAsset) async{
        final filePath = await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

        File tempFile = File(filePath);
        if (tempFile.existsSync()) {
          imgFile.add(tempFile);
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text("Phone Scanner"),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
        actions: <Widget>[
          Visibility(
            visible: _visible,
            child: IconButton(
              onPressed: (){navToShow();},
              icon: Icon(Icons.edit),
            ),
          ),
          Visibility(
            visible: _visible,
            child: IconButton(
              onPressed: (){delItem();},
              icon: Icon(Icons.delete),
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.grey[800],
                  child: FlatButton.icon(
                    onPressed: (){
                      loadAssets();
                    },

                    icon: Icon(
                      Icons.image,
                      color: Colors.grey[400] ,
                    ),
                    label: Text(
                      "Select Images",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                      ),
                    ),
                    color: Colors.grey[800],
                  ),
                ),
              ),


            ],

          ),
          Expanded(
            flex: 9,
            child: Container(
              child: images.isEmpty?Center(child: Text(
                "Select Images to display here",
                style: TextStyle(
                  color: Colors.grey[400],
                  letterSpacing: 1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              )
                  :GridView.count(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,
                children: List.generate(images.length, (index){
                  Asset asset = images[index];
                  return new Card(
                    child: new InkResponse(
                      child: AssetThumb(
                          asset: asset,
                          width: 300,
                          height: 300
                      ),
                      onTap: (){_toggle(index);},
                    ),
                  );
                }),
              ) ,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: FlatButton.icon(
                onPressed: () async{
                  for(int i=0;i<imgFile.length;i++){
                    img.add(PdfImage.file(
                      pdf.document,
                      bytes: imgFile[i].readAsBytesSync(),));
                    pdf.addPage(
                        pw.Page(
                            build: (pw.Context context){
                              return pw.Center(
                                child: pw.Image(img[i]),
                              );
                            }
                        ));
                  }
                  try{
                    print("creating folder");
                    final tempDir = await getExternalStorageDirectory();
                    final myImagePath = '${tempDir.parent.parent.parent.parent.path}/Phone Scanner' ;
                    final myImgDir = await new Directory(myImagePath).create();
                    final output = File(path.join(myImgDir.path, '${DateTime.now().toString().replaceAll(" ","_")}.pdf'));
                    await output.writeAsBytes(pdf.save());
                  }catch(Exception){

                  }
                },
                color: Colors.grey[800],
                icon: Icon(Icons.picture_as_pdf),
                label: Text(
                  "Convert to PDF",
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

