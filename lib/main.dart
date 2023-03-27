import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Appointment.dart';
import 'package:firstapp/Fever.dart';
import 'package:firstapp/outscreen2.dart';
import 'package:firstapp/tempsen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
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
                      padding: EdgeInsets.only(top: 350+(_op*60),bottom:50),
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
                      onPressed: () {
                        print('clicked');
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

