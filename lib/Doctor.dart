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
import 'main.dart';
import 'outscreen2.dart';
import 'Fever.dart';
import 'Corona.dart';
import 'rfid.dart';
import 'card.dart';

class Doctor extends StatefulWidget {
  const Doctor({Key? key}) : super(key: key);

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height:double.infinity,
        decoration:BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Wallpaper2.jpg"),
              fit: BoxFit.cover
          ),
        ),
        child:Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Yoyr details are received!',
                  style:TextStyle(fontSize: 30,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child:Align(
                  alignment: Alignment.center,
                  child: Text('Your Appointment is Fixed',
                    style:TextStyle(fontSize: 30,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child:Align(
                  alignment: Alignment.center,
                  child: Text('Please move to the Waiting Hall for further consultation!',
                    style:TextStyle(fontSize: 30,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child:Align(
                  alignment: Alignment.center,
                  child: Text('Get Well Soon!!!',
                    style:TextStyle(fontSize: 30,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
