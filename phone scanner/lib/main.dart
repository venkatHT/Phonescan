import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'BHome.dart';

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
        BHome())));
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blue[100],
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
                    SizedBox(height: 60,),

                    Container(
                       child: Text("powered by ",
                         style: TextStyle(
                         color: Colors.black,

                       ),
                        )
                    ),

                    Container(
                        child: Text(
                            "HIBERNATE TECHNOLOGIES Pvt. Ltd.",
                          style: TextStyle(
                            color: Colors.black,

                          ),
                        )
                    ),
                  ],
                ),)
          ),

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



