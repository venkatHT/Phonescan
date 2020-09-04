import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;

class Sfc extends StatefulWidget {
  @override
  _SfcState createState() => _SfcState();
}

class _SfcState extends State<Sfc> {
  List<File> imgFile = List<File>();
  List<dynamic> img = [];
  List<File> _files = [];
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new GridView.builder(
              itemCount: _files.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,

              ),
              itemBuilder: (context, index) {
                return displaySelectedFile(_files[index]);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: FlatButton.icon(
                onPressed: () async{
                  for (var i = 0; i < _files.length; i++) {
                    // added this
                    var image = PdfImage.file(
                      pdf.document,
                      bytes: File(_files[i].path).readAsBytesSync(),
                    );

                    pdf.addPage(pw.Page(
                        pageFormat: PdfPageFormat.a4,
                        build: (pw.Context context) {
                          return pw.Center(child: pw.Image(image));
                        }));
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