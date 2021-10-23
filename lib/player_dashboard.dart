import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerDashboard extends StatefulWidget {
  const PlayerDashboard({Key? key}) : super(key: key);

  @override
  _PlayerDashboardState createState() => _PlayerDashboardState();
}

class _PlayerDashboardState extends State<PlayerDashboard> {
  final db = FirebaseFirestore.instance;
  late String name,id,city;
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
          stream: db.collection('players').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Container(

                decoration: BoxDecoration(
                  image: DecorationImage(

                    image: AssetImage("img/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  children: snapshot.data!.docs.map((doc) {
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
                        doc['name'],
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            doc['title'],style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            doc['date'],style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      trailing: Text(doc['score'].toString(),style: TextStyle(fontSize: 22),),
                    );
                  }).toList(),
                ),
              );
          },
        ),
      ),
    );
  }

}
