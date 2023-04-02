import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firstapp/outscreen2.dart';
import 'package:firstapp/reusable.dart';
import 'package:firstapp/tempsen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Appointment.dart';

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  late String url='';
  //final url="https://blynk.cloud/external/api/update?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v3=1";

_launchurl() {
  const url="https://video.sebastienbiollo.com/wut-xwsj-uvw";
  launch(url);
}

  void postData(String urls,var a) async{
    //assert(a != null);
    try{
      print(a);
      print(urls);
      final response = await get(Uri.parse(urls));
      print("hi"+response.body);
    }catch(err){}
  }

  @override
  Widget build(BuildContext context) {
    late double _op;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height:double.infinity,
        decoration:BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Into1.png"),
              fit: BoxFit.cover
          ),
        ),
        child:Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder(
                    child:Center(
                      child: Text('Where would you like Dr.MAT to function?',
                        textAlign: TextAlign.center,
                        style:TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                        ,),
                    ),
                    tween: Tween<double>(begin: 0,end: 1,),
                    duration: Duration(seconds: 1),
                    builder :(BuildContext context,double _op,Widget? child){
                      return Opacity(
                        opacity: _op,
                        child: Padding(
                          padding: EdgeInsets.only(top: 400+(_op*60),bottom:50),
                          child:child,
                        ),
                      );
                    }
                ),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TweenAnimationBuilder(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(width:2, color:Colors.blue),
                            primary: Colors.white.withOpacity(1), // background
                            onPrimary: Colors.blue, // foreground
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            )
                        ),
                        onPressed:(){
                          var a='0';
                          final String url="https://blynk.cloud/external/api/update?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v3="+a;
                          postData(url, a);
                          print(url);
                          _launchurl();
                        },
                        child: Text('Indoor',
                          style:TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,)
                          ,),
                      ),
                      tween: Tween<double>(begin: 0,end: 1,),
                      duration: Duration(seconds: 4),
                      builder :(BuildContext context,double _op,Widget? child){
                        return Opacity(
                          opacity: _op,
                          child: child,
                        );
                      }
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TweenAnimationBuilder(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(width:2, color:Colors.blue),
                            primary: Colors.white.withOpacity(1), // background
                            onPrimary: Colors.blue, // foreground
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            )
                        ),
                        onPressed: () {
                          print('clicked out');
                          //int mode;
                          //dbRef.push().set(mode);
                          var a='1';
                          final String url="https://blynk.cloud/external/api/update?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v3="+a;
                          //pushdata(url,a);
                          postData(url, a);
                          print(url);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> tempsen()));

                        },
                        child: Text('Outdoor',
                          style:TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,)
                          ,),
                      ),
                      tween: Tween<double>(begin: 0,end: 1,),
                      duration: Duration(seconds: 4),
                      builder :(BuildContext context,double _op,Widget? child){
                        return Opacity(
                          opacity: _op,
                          child: child,
                        );
                      }
                  ),
                ),
              ],
            )
        ) ,
      ),
    );
  }
}
