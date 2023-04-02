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

class tempsen extends StatefulWidget {
  const tempsen({Key? key}) : super(key: key);

  @override
  State<tempsen> createState() => _tempsenState();
}

class _tempsenState extends State<tempsen> {
  final VideoPlayerController videoPlayerController = VideoPlayerController.asset("assets/tempsensorslide.mp4");
  final auth =FirebaseAuth.instance;
  final ref1= FirebaseDatabase.instance.ref('Distance');
  final url = "https://blynk.cloud/external/api/get?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v0";
  late String urla='';
  static int flag=1;
  String distdata ='';

  ChewieController? chewieController;
  void FetchPosts() async
  {
    try {
      final response = await get(Uri.parse(url));
      final data = jsonDecode(response.body) ;
      //print(data.toString());

      setState(() {
        distdata=data.toString();
        print(distdata);
      });
    }catch(err){}
  }

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
    FetchPosts();
    super.initState();
  }

  @override
  void dispose(){
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  void postData(String urls,var a) async{
    //assert(a != null);
    try{
      print(a);
      print(urls);
      final response = await get(Uri.parse(urls));
      print(response.body);
    }catch(err){}
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
                String val=snapshot.child('dist').value.toString();
                double val1=double.parse(val);
                print(val1);
                int ddd = int.parse(distdata);
                if(ddd==1 || val1==1) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    DateTime now = DateTime.now();

                    String currentTimeString = "${now.hour}:${now.minute}:${now.second}";
                    print(currentTimeString);
                    //var a='0';
                    final String urla="https://blynk.cloud/external/api/update?token=DVdlR6DDxV7fRK9rLZRVHo38YBPwy1mf&v4="+currentTimeString;
                    postData(urla, currentTimeString);
                    print(urla);
                    var duration = Duration(seconds: 5);
                    Timer(duration, () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => sensetime()));
                    });
                  });
                }
                else if(ddd==0 || val1==0)
                  {
                    if(flag==1) {
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      //   //Navigator.push(context,
                      //   //MaterialPageRoute(builder: (context) => Fever()));
                      //
                      // });
                      var duration = Duration(seconds: 5);
                      Timer(duration, () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => tempsen()));
                      });
                      flag=0;
                    }
                  }


                return  Center(
                  child: SizedBox(
                    height: 1,
                  ),
                );
              }
          ),
          TweenAnimationBuilder(
              child: Padding(
                padding:EdgeInsets.only(top:750,left:185),
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
