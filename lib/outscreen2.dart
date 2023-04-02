import 'dart:async';
import 'dart:ffi';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Appointment.dart';
import 'package:firstapp/Fever.dart';
import 'package:firstapp/befever.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'main.dart';
import 'package:http/http.dart';
import 'reusable.dart';

class outscreen2 extends StatefulWidget {
  const outscreen2({Key? key}) : super(key: key);

  @override
  State<outscreen2> createState() => _outscreen2State();
}

class _outscreen2State extends State<outscreen2> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Temperature');
  final url = "https://blynk.cloud/external/api/get?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v1";

  String tempdata ='';


  void FetchPosts() async
  {
    try {
      final response = await get(Uri.parse(url));
      final data = jsonDecode(response.body) ;
      //print(data.toString());

      setState(() {
         tempdata=data.toString();
         //print(tempdata);
      });
    }catch(err){}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/outscreen22.png"),
              fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Column(
            children: [
              TweenAnimationBuilder(
                  child: Text('Your current body temperature is',
                    style: TextStyle(fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  tween: Tween<double>(begin: 0, end: 1,),
                  duration: Duration(seconds: 1),
                  builder: (BuildContext context, double _op, Widget? child) {
                    return Opacity(
                      opacity: _op,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 300 + (_op * 60), bottom: 30),
                        child: child,
                      ),
                    );
                  }
              ),
              Expanded(
                child: FirebaseAnimatedList
                  (query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      String val = snapshot
                          .child('temp')
                          .value
                          .toString();
                      //String val1=snapshot.child('temp').value.toString();
                      double val1 = double.parse(val);
                      //final val1=ModalRoute.of(context)?.settings.arguments as int;
                      print(" FB Temperature  is :");
                      print(val1);
                      double tdd = double.parse(tempdata);
                      //tdd+=20;
                      print(tempdata);

                      if (tdd> 98.7) {
                        print("printed");
                        var duration = Duration(seconds: 8);
                        Timer(duration, () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => befever()));
                        });
                        //for(int i=0;i<3000;i++);
                        // SchedulerBinding.instance.addPostFrameCallback((_) {
                        //   //Navigator.push(context,
                        //   //MaterialPageRoute(builder: (context) => Fever()));
                        //
                        // });
                      }
                      else if (val1 < 98.7) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          //Navigator.push(context,
                          //MaterialPageRoute(builder: (context) => Fever()));
                          var duration = Duration(seconds: 8);
                          Timer(duration, () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => Appointment()));
                          });
                        });
                      }

                      return Center(
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 2, color: Colors.blue),
                              onSurface: Colors.white,
                              primary: Colors.white, // background
                            ),
                            onPressed: () {},
                            child: Text(tdd.toString() + '°F',
                              style: TextStyle(fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Appointment');
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Appointment()));
          });
        },
        child: const Icon(Icons.add_alarm_sharp),
      ),
    );
  }
}





