import 'dart:async';
import 'dart:ffi';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Appointment.dart';
import 'package:firstapp/Thankyou.dart';
import 'package:firstapp/sensetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';
import 'main.dart';
import 'outscreen2.dart';
import 'Fever.dart';
import 'Corona.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'rfid.dart';
import 'card.dart';
import 'sensetime.dart';
import 'package:http/http.dart';


class befever extends StatefulWidget {
  const befever({Key? key}) : super(key: key);

  @override
  State<befever> createState() => _befeverState();
}

class _befeverState extends State<befever> {
  final VideoPlayerController videoPlayerController = VideoPlayerController.asset("assets/befever.mp4");
  final auth =FirebaseAuth.instance;
  final ref1= FirebaseDatabase.instance.ref('Oxygen');

  ChewieController? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    chewieController=ChewieController
      (videoPlayerController: videoPlayerController,
      autoPlay: true,
      aspectRatio: 10/21,
      looping: false,
      autoInitialize:true,
      showControls: false,
    );
    super.initState();
  }

  @override
  void dispose(){
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(child: Chewie(controller: chewieController!,),),
          FirebaseAnimatedList
            (query: ref1,
              defaultChild: Text(''),
              itemBuilder: (context,snapshot,animation,index){
                String val=snapshot.child('rate').value.toString();
                //String val1=snapshot.child('temp').value.toString();
                double val1=double.parse(val);
                //final val1=ModalRoute.of(context)?.settings.arguments as int;
                print("Heart rate is :");
                print(val1);
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  //Navigator.push(context,
                  //MaterialPageRoute(builder: (context) => Fever()));
                  var duration=Duration(seconds: 15);
                  Timer(duration, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Fever()));
                  });
                });


                return  Center(
                  child: SizedBox(
                    height: 1,
                  ),
                );
              }
          ),
          TweenAnimationBuilder(
              child: Padding(
                padding:EdgeInsets.only(top:775,left:185),
                child:CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.blueGrey,
                ),
              ),
              tween: Tween<double>(begin: 0,end: 1,),
              duration: Duration(seconds: 5),
              builder :(BuildContext context,double _op,Widget? child){
                return Opacity(
                  opacity: _op,
                  child: child,
                );
              }
          ),

        ],
      ),
    );
  }
}



