import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'SliderPage.dart';

void main() =>
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      home: SplashScreen(),

    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), ()=> Navigator.push(
        context, MaterialPageRoute(builder: (context) =>
        SliderPage())));
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width:double.infinity,
          child: Container(
              child: Padding(padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: new CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100,
                          child: Image.asset('images/logo.png'),
                        )
                    ),
                    SizedBox(height: 40,),
                    Container(
                       child: Text("powered by "
                          ,

                         style: TextStyle(
                         color: Colors.black,


                       ),



                        )

                    ),

                    Container(
                        child: Text(
                            "HIBERNATE TECHNOLOGIES PVT LIMITED",
                          style: TextStyle(
                            color: Colors.black,

                          ),



                        )
                    ),
                  ],
                ),)
          ),
        ),
      );
    }
  }



