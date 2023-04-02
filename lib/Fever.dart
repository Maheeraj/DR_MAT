import 'dart:async';
import 'dart:ffi';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Appointment.dart';
import 'package:firstapp/Corona.dart';
import 'package:firstapp/infopage.dart';
import 'package:firstapp/triage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'main.dart';
import 'outscreen2.dart';
import 'infopage.dart';

class Fever extends StatefulWidget {
  const Fever({Key? key}) : super(key: key);

  @override
  State<Fever> createState() => _FeverState();
}

class _FeverState extends State<Fever> {
  final auth =FirebaseAuth.instance;
  final ref= FirebaseDatabase.instance.ref('Oxygen');
  final ref1=FirebaseDatabase.instance.ref('Heart');
  int flag=0;
  final url = "https://blynk.cloud/external/api/get?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v2";
  final urlh = "https://blynk.cloud/external/api/get?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v3";

  String spo2data ='';
  String bpmdata ='';

  void FetchPosts() async
  {
    try {
      final response = await get(Uri.parse(url));
      final data = jsonDecode(response.body) ;
      //print(data.toString());
      final responsebpm = await get(Uri.parse(urlh));
      final datad = jsonDecode(responsebpm.body) ;

      setState(() {
        spo2data=data.toString();
        //print(tempdata);
        bpmdata=datad.toString();
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
        height:double.infinity,
        decoration:BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Fever2.png"),
              fit: BoxFit.cover
          ),
        ),
        child:Center(
          child: Column(
            children: [
              TweenAnimationBuilder(
                  child: Text('Your current SpO2 levels are',
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
                        padding: EdgeInsets.only(top: 250+(_op*60),bottom:10),
                        child:child,
                      ),
                    );
                  }
              ),
              Expanded(
                  child: FirebaseAnimatedList            // Temp value from firebase
                    (query: ref,
                      defaultChild: Text('...'),
                      itemBuilder: (context,snapshot,animation,index){
                        String val=snapshot.child('spo2').value.toString();
                        //String val1=snapshot.child('temp').value.toString();
                        double val1=double.parse(val);
                        //final val1=ModalRoute.of(context)?.settings.arguments as int;
                        print("SpO2 is :");
                        print(val1);
                        int sdd = int.parse(spo2data);
                        //tdd+=20;
                        print('Spo2:' +spo2data );
                        if((val1<90 && val1>70)||(sdd<90)&&(sdd>70))
                        {
                          print("printed");
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            //Navigator.push(context,
                            //MaterialPageRoute(builder: (context) => Fever()));
                            var duration=Duration(seconds: 8);
                            Timer(duration, () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => triage()));
                            });
                          });
                        }
                        else if(val1<70 || sdd<70)
                        {
                          print("Go to ICU");
                          var duration=Duration(seconds: 8);
                          Timer(duration, () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Corona()));
                          });
                          // SchedulerBinding.instance.addPostFrameCallback((_) {
                          //   //Navigator.push(context,
                          //   //MaterialPageRoute(builder: (context) => Fever()));
                          //
                          // });
                        }

                        else if( val1 >90 || sdd>90)
                        {
                          print("printed");
                          var duration=Duration(seconds: 8);
                          Timer(duration, () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => infopage()));
                          });
                          // SchedulerBinding.instance.addPostFrameCallback((_) {
                          //   //Navigator.push(context,
                          //   //MaterialPageRoute(builder: (context) => Fever()));
                          //
                          // });
                        }

                        return  Center(
                          child: SizedBox(
                            width:300,
                            height: 50,
                            child:ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(width:2, color:Colors.blue),
                                onSurface: Colors.white,
                                primary: Colors.white, // background
                              ),
                              onPressed: (){},
                              child: Text(val+' %',
                                style:TextStyle(fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
              ),

              TweenAnimationBuilder(
                  child: Text('Your current Heart rate is',
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
                        padding: EdgeInsets.only(bottom:30),
                        child:child,
                      ),
                    );
                  }
              ),
              Expanded(
                child: FirebaseAnimatedList
                  (query: ref1,
                    defaultChild: Text('Loading'),
                    itemBuilder: (context,snapshot,animation,index){
                      String val=snapshot.child('rate').value.toString();
                      //String val1=snapshot.child('temp').value.toString();
                      double val1=double.parse(val);
                      //final val1=ModalRoute.of(context)?.settings.arguments as int;
                      print("Heart rate is :");
                      print(val1);
                      double bdd = double.parse(bpmdata);
                      //tdd+=20;
                      print('BP:'+bpmdata );


                      return  Center(
                        child: SizedBox(
                          width:300,
                          height: 50,
                          child:ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width:2, color:Colors.blue),
                              onSurface: Colors.white,
                              primary: Colors.white, // background
                            ),
                            onPressed: (){},
                            child: Text(bdd.toString()+' BPM',
                              style:TextStyle(fontSize: 25,
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
      floatingActionButton: FloatingActionButton(onPressed:()
      {
        print('Appointment');
        SchedulerBinding.instance.addPostFrameCallback((_){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Appointment()));
        });
      },
        child: const Icon(Icons.add_alarm_sharp),
      ),
    );
  }
}


