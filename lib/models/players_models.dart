import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel{
  String? id;
  String? name;
  int? score;
  num? higest;
  String? titel;
  String? mail;
  String? achievement;
  String? date;
  Timestamp? dates;


  UserInfoModel(
      {this.id="NULL",
        this.name='NULL',
        this.score=null,
        this.higest=null,
        this.titel="NULL",
        this.mail="NULL",
        this.achievement="NULL",
        this.date="NULL",
        this.dates=null});

  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{
      'id':id,
      'name':name,
      'score':score,
      'higest':higest,
      'titel':titel,
      'mail':mail,
      'achievement':achievement,
      'date':date,
      'dates':dates,
      
    };

    return map;
  }


  factory UserInfoModel.fromMap(Map<String,dynamic> map)=> UserInfoModel(
    id:map['id'],
    name:map['name'],
    score:map['score'],
    higest:map['higest'],
    titel:map['titel'],
    mail:map['mail'],
    achievement:map['achievement'],
    date:map['date'],
    dates:map['dates'],

  );

  @override
  String toString() {
    return 'UserInfoModel{id: $id, name: $name, score: $score, higest: $higest, titel: $titel, mail: $mail, achievement: $achievement, date: $date, dates: $dates}';
  }
}