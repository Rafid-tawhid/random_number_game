import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:random_number_game/auth/firebase_auth.dart';
import 'package:random_number_game/models/user_details.dart';
import 'package:random_number_game/models/user_details.dart';


class PlayerDashboard extends StatefulWidget {

  static const String routeName='/page_player_dashboard';
  @override
  _PlayerDashboardState createState() => _PlayerDashboardState();
}

class _PlayerDashboardState extends State<PlayerDashboard> {
  final db = FirebaseFirestore.instance;
  late String name,id,city;
  late String title;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('World Records'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('players').orderBy('score',descending: true).snapshots(),

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blueAccent,),
              );
            } else
              return Container(

                decoration: BoxDecoration(
                  image: DecorationImage(

                    image: AssetImage("img/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: ListView(
                //   children: snapshot.data!.docs.map((doc) {
                //
                //     return ListTile(
                //       leading: Padding(
                //         padding: const EdgeInsets.all(3.0),
                //         child: CircleAvatar(
                //           backgroundColor: Colors.white,
                //           child: Icon(
                //             Icons.wine_bar_rounded,
                //             color: Colors.deepOrange,
                //             size: 30.0,
                //           ),
                //
                //         ),
                //       ),
                //       title: Text(
                //
                //         doc['name'],
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       subtitle: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //        Text(
                //             doc['title'],style: TextStyle(color: Colors.red),
                //           ),
                //           Text(
                //             doc['date'],style: TextStyle(color: Colors.blue),
                //           ),
                //         ],
                //       ),
                //       trailing: Text(doc['score'].toString(),style: TextStyle(fontSize: 22),),
                //
                //     );
                //   }).toList(),
                // ),
                child: ListView.builder(itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){

                  QueryDocumentSnapshot user=snapshot.data!.docs[index];

                  return ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.wine_bar_rounded,
                          color: Colors.deepOrange,
                          size: 30.0,
                        ),

                      ),
                    ),
                    title: Text(

                      user['name'],
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          user['titel'],style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          user['date'],style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    trailing: Text(user['score'].toString(),style: TextStyle(fontSize: 22),),

                  );;
                }),
              );
          },
        ),
        
      ),
    );
  }



}
