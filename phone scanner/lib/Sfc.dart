import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;

import 'image_editor_.dart';


class Sfc extends StatefulWidget {
  File filedit;
  Sfc({this.filedit});


  @override
  _SfcState createState() => _SfcState();
}

class _SfcState extends State<Sfc> {
  static GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  List<dynamic> img = [];
  List<File> _files = [];
  final pdf = pw.Document();
  bool _visible = false;
  int i = 0;

  File _image;
  Future<void> getimageditor() {
    final geteditimage =
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImageEditorPro(
        appBarColor: Colors.grey[800],
        bottomBarColor: Colors.grey[700],
        imagefile: _files[i],
      );
    })).then((geteditimage) {
      if (geteditimage != null) {
        setState(() {
          _image = geteditimage;
          _files[i] = _image;
        });
      }
    }).catchError((er) {
      print(er);
    });
  }

  void _toggle(int i){
    setState(() {
       this.i = i;
      _visible = !_visible;
    });
  }

  void delItem(){
    setState(() {
      _files.removeAt(i);
    });
  }

  void setItem(){
    setState(() {
      _files[i] = widget.filedit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
        centerTitle: true,
        actions: <Widget>[
          Visibility(
            visible: _visible,
            child: IconButton(
              onPressed: (){getimageditor();},
              icon: Icon(Icons.edit,
                color: Colors.white,),
            ),
          ),
          Visibility(
            visible: _visible,
            child: IconButton(
              onPressed: (){delItem();},
              icon: Icon(Icons.delete,
                color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new GridView.builder(
                itemCount: _files.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return new Card(
                      child: new InkResponse(
                      child: Image.file(_files[index]),
                      onTap: (){
                        _toggle(index);
                      },
                      ),
                  );
                },
              ),

            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: FlatButton.icon(
                onPressed: () async{
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: 'PDF created. It will display in Home Screen, If it not there, just Restart the App',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white
                  );
                  for(int i=0;i<_files.length;i++){
                    img.add(PdfImage.file(
                      pdf.document,
                      bytes: _files[i].readAsBytesSync(),));
                    pdf.addPage(
                        pw.Page(
                            build: (pw.Context context){
                              return pw.Column(

                                children: <pw.Widget>[
                                  pw.Expanded(
                                    flex: 21,
                                    child: pw.Container(
                                      child: pw.Center(
                                        child: pw.Image(img[i]),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      child: pw.Text(
                                        "PHONE SCANNER",
                                      ),
                                    ),
                                  ),

                                ],
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
                color: Colors.black,

                icon: Icon(Icons.picture_as_pdf,
                  color: Colors.white,
                ),
                label: Text(
                  "Convert to PDF",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File cameraFile;
          print('Pressed');
          // ignore: deprecated_member_use
          cameraFile = await ImagePicker.pickImage(source: ImageSource.camera);
          print(cameraFile.path);
          List<File> temp = _files;
          temp.add(cameraFile);
          setState(() {
            _files = temp;
          });
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget displaySelectedFile(File file) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 500.0,
        width: 500.0,
        child: Image.file(file),

      ),

    );
  }

}