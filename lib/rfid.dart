import 'dart:async';
import 'dart:ffi';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Appointment.dart';
import 'package:firstapp/Exit.dart';
import 'package:firstapp/Thankyou.dart';
import 'package:firstapp/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'main.dart';
import 'outscreen2.dart';
import 'Fever.dart';
import 'Corona.dart';

class rfid extends StatefulWidget {
  const rfid({Key? key}) : super(key: key);

  @override
  State<rfid> createState() => _rfidState();
}

class _rfidState extends State<rfid> {

  final auth =FirebaseAuth.instance;
  final ref= FirebaseDatabase.instance.ref('Ir1');
  final ref1= FirebaseDatabase.instance.ref('Ir2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height:double.infinity,
          decoration:BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/rfid1.png"),
                fit: BoxFit.cover
            ),
          ),
          child:Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder(
                      child: Text("Do you have a RFID Card?",
                        textAlign: TextAlign.center,
                        style:TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      tween: Tween<double>(begin: 0,end: 1,),
                      duration: Duration(seconds: 1),
                      builder :(BuildContext context,double _op,Widget? child){
                        return Opacity(
                          opacity: _op,
                          child: Padding(
                            padding: EdgeInsets.only(top: 250+(_op*60),bottom:30),
                            child:child,
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 30,left:53),
                        child:SizedBox(
                          height: 50,
                          width: 125,
                          child:ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              side: BorderSide(width:2, color:Colors.blue),
                              primary: Colors.white, // background
                              onPrimary: Colors.blue, // foreground
                            ),
                            onPressed: () {
                              print('clicked yes');
                            },
                            child: Text('YES',
                              style:TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 30),
                        child:
                        SizedBox(
                          height: 50,
                          width: 125,

                          child:ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              side: BorderSide(width:2, color:Colors.blue),
                              primary: Colors.white, // background
                              onPrimary: Colors.blue, // foreground
                            ),
                            onPressed: () {
                              print('clicked no');
                            },
                            child: Text('NO',
                              style:TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TweenAnimationBuilder(
                      child: Text("Kindly move your hand above the respective buttons",
                        textAlign: TextAlign.center,
                        style:TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      tween: Tween<double>(begin: 0,end: 1,),
                      duration: Duration(seconds: 1),
                      builder :(BuildContext context,double _op,Widget? child){
                        return Opacity(
                          opacity: _op,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10+(_op*60),bottom:80),
                            child:child,
                          ),
                        );
                      }
                  ),
                  /*CircularProgressIndicator(
                  color: Colors.blueAccent,
                  backgroundColor: Colors.blueGrey,
                ),*/
                  Expanded(
                    child: FirebaseAnimatedList
                      (query: ref,
                        defaultChild: Text(''),
                        itemBuilder: (context,snapshot,animation,index){
                          String val=snapshot.child('read1').value.toString();
                          //String val1=snapshot.child('temp').value.toString();
                          double val1=double.parse(val);
                          //final val1=ModalRoute.of(context)?.settings.arguments as int;
                          print("Ir1 is :");
                          print(val1);
                          if(val1==1)
                          {
                            print("Ir1:Yes");
                            print("RFID- Yes");
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              //Navigator.push(context,
                              //MaterialPageRoute(builder: (context) => Fever()));
                              var duration=Duration(seconds: 8);
                              Timer(duration, () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => card()));
                              });
                            });
                          }
                          if(val1==0)
                          {
                            print("Called hi");
                          }
                          return Text('');
                        }
                    ),
                  ),
                  Expanded(
                    child:FirebaseAnimatedList(
                        query: ref1,
                        itemBuilder: (context, snapshot, animation, index) {
                          print("Hi");
                          String val2 = snapshot.child('read2').value.toString();
                          //String val1=snapshot.child('temp').value.toString();
                          double val3 = double.parse(val2);
                          print("Ir2  is :");
                          print(val3);
                          if (val3 == 1) {
                            print("Ir2:Yes");
                            print("RFID - No");
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              //Navigator.push(context,
                              //MaterialPageRoute(builder: (context) => Fever()));
                              var duration = Duration(seconds: 8);
                              Timer(duration, () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Exit()));
                              });
                            });
                          }
                          return Text('',);
                        }
                    ),
                  ),
                  TweenAnimationBuilder(
                      child: Padding(
                        padding:EdgeInsets.only(bottom: 15),
                        child:CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                      tween: Tween<double>(begin: 0,end: 1,),
                      duration: Duration(seconds: 3),
                      builder :(BuildContext context,double _op,Widget? child){
                        return Opacity(
                          opacity: _op,
                          child: child,
                        );
                      }
                  ),
                ],
              )
          )
      ),
    );
  }
}
