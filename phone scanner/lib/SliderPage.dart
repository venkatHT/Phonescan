import 'dart:async';

import 'package:PhoneScanner/BHome.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';



class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body:
        Carousel(

        showIndicator: false,

        animationDuration: Duration(milliseconds: 600),

        images: [
          AssetImage('images/homepage.jpg'),
          AssetImage('images/camerapage.jpg'),
          AssetImage('images/gallerypage.jpg'),
          AssetImage('images/selectpage.jpg'),

        ],

        ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(context: context,
              barrierDismissible:false,
              builder:(BuildContext context){
                return Center(
                  child: Opacity(opacity: 1.0,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent),
                    ),),
                );
              });
          Timer(Duration(seconds: 5), ()=> Navigator.push(
              context, MaterialPageRoute(builder: (context) =>
              BHome())));
        },
        label: Text('Start'),
        icon: Icon(Icons.arrow_right),
        backgroundColor: Colors.orangeAccent,
        elevation: 10,),

    );
  }
}