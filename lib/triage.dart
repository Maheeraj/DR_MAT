import 'dart:async';
import 'dart:ffi';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Appointment.dart';
import 'package:firstapp/Thankyou.dart';
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

class triage extends StatefulWidget {
  const triage({Key? key}) : super(key: key);

  @override
  State<triage> createState() => _triageState();
}

class _triageState extends State<triage> {
  final VideoPlayerController videoPlayerController = VideoPlayerController.asset("assets/triage.mp4");
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
               //  String val=snapshot.child('rate').value.toString();
               //  //String val1=snapshot.child('temp').value.toString();
               //  double val1=double.parse(val);
               //  //final val1=ModalRoute.of(context)?.settings.arguments as int;
               //  print("Heart rate is :");
               //  print(val1);
               // /* SchedulerBinding.instance.addPostFrameCallback((_) {
               //    //Navigator.push(context,
               //    //MaterialPageRoute(builder: (context) => Fever()));
               //    var duration=Duration(seconds: 10);
               //    Timer(duration, () {
               //      Navigator.push(context,
               //          MaterialPageRoute(builder: (context) => outscreen2()));
               //    });
               //  });*/


                return  Center(
                  child: SizedBox(
                    height: 1,
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
