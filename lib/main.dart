
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_number_game/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(

      backgroundColor: Colors.white,
      body: SplashScreen(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  var _score = 0;
  var _higestScore = 0;
  var _sum = 0;
  var _index1 = 0;
  var _index2 = 0;
  var _rand1 = 0;
  var _rand2 = 0;
  var _rand3 = 0;
  var a = 0;
  var b = 0;
  var c = 0;
  var d = 0;
  bool showMsg = false;
  var _isGameOver = false;
  var _id=0;
  var _name='Rafid Tawhid';
  var _title='Legend';
  var _city='Dhaka';
  var _achivement='Concurer';
  var _date;
  DateTime now = DateTime.now();
  String nameS="Bot User",idS="10",cityS="Dhaka";
  List<int> list = [];
  final _random = Random.secure();
  final _diceList = <String>[
    'img/nm1.JPG',
    'img/nm2.JPG',
    'img/nm3.JPG',
    'img/nm4.JPG',
    'img/nm5.JPG',
    'img/nm6.JPG',
    'img/nm7.JPG',
    'img/nm8.JPG',
    'img/nm9.JPG',
  ];

  ///
  ///
  late FToast fToast;


  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

  }


  @override
  Widget build(BuildContext context) {

    //initial call
    _rollTheDice();
    _readHigestScore();


    return Center(
      child: SingleChildScrollView(
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Higest Score :$_higestScore',
                    style: TextStyle(fontSize: 18,),
                  ),

                ],
              ),
            ),
            SizedBox(height: 50,),

            Text(
              'Score :$_score',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 50,),
            if (showMsg)
              Center(
                  child: Image.asset('img/anim2.gif',height: 150,width: 200,),)
            else
              Center(
              child: Image.asset('img/anim3.gif',height: 150,width: 200,),

              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          _diceList[_index1],
                          height: 70,
                          width: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'img/plus.JPG',
                          height: 60,
                          width: 60,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          _diceList[_index2],
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Text('sum :$_sum',style: TextStyle(fontSize: 20),),
            const SizedBox(
              height: 20,
            ),
            if (_isGameOver)
              const Text(
                "G A M E  O V E R",
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 35.0,
                      child: RaisedButton(
                        onPressed: () {
                          checkRes(a);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "$a",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      height: 35.0,
                      child: RaisedButton(
                        onPressed: () {
                          checkRes(b);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "$b",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //buttns1,2

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 35.0,
                      child: RaisedButton(
                        onPressed: () {
                          checkRes(c);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "$c",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      height: 35.0,
                      child: RaisedButton(
                        onPressed: () {
                          checkRes(d);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "$d",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //buttns3,4
            ElevatedButton(onPressed: _rollTheDice, child: Text("Roll")),
          ],
        ),
      ),
    );
  }

  void _rollTheDice() {


    if(_score>_higestScore)
    {
      _higestScore=_score;
      _saveLastScore(_higestScore);
    }

    setState(() {
      _index1 = _random.nextInt(9);
      _index2 = _random.nextInt(9);
      _rand1 = _random.nextInt(24);
      _rand2 = _random.nextInt(24);
      _rand3 = _random.nextInt(24);

      _sum = _index1 + _index2 + 2;
      // _score =_score +_index1 + _index2 + 2;

      suffle(_rand1, _rand2, _rand3, _sum);
    });
  }

  void suffle(int rand1, int rand2, int rand3, int sum) {
    if (rand1 == rand2) {
      _rand2 = _rand2 + 1;
    }
    if (rand1 == rand3) {
      _rand3 = _rand3 + 1;
    }
    if (rand1 == rand3) {
      _rand1 = _rand1 + 1;
    }
    if (_rand1 == sum || _rand2 == sum || _rand3 == sum) {
      _rand1 = _rand1 + 2;
      _rand2 = _rand2 + 3;
      _rand3 = _rand3 + 1;
    }

    list = [rand1, rand2, rand3, sum];
    list.shuffle();
    print(list);

    a = list[0];
    b = list[1];
    c = list[2];
    d = list[3];
    print("$a" + " " "$b" + " " + "$c" + " " "$d");
  }

  checkRes(int a) {
    print(a);
    int aa = a;
    if (aa == _sum) {
      _rollTheDice();
      setState(() {
        showMsg = true;
      });
      _score++;
    } else {
      print("ERROR");

      showToast();

    }
  }


  showToast() {
    Widget toast = Container(
      height: 320,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey, //                   <--- border color
          width: 1.0,
        )
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                color: Colors.red,
            ),

            child:Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error,color: Colors.white,size: 30,),
                SizedBox(
                  width: 14.0,
                ),
                Center(child: Text("Wrong Answer",style: TextStyle(fontSize: 24,color: Colors.white),)),

              ],


            ),
          ),
          Container(
            height: 180
            ,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Better Luck Next Time",style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 14.0,
                ),
                Text("Do You Want to Play Again ?",style: TextStyle(fontSize: 20),),
              ],
            ),
          ),),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  child: new Text('Exit',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    _date=now.hour.toString() + ":" + now.minute.toString() + ":" + now.day.toString()+now.month.toString();
                    fetchUsersData();

                    _storeDatatoFirebase(idS,nameS,_score,_date,_higestScore,_title,cityS,_achivement);

                    fToast.removeCustomToast();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SplashScreen()));
                    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
                SizedBox(
                  width: 14.0,
                ),
                FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  child: new Text('Play',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    customToastShow();
                    _date=now.hour.toString() + ":" + now.minute.toString() + ":" + now.day.toString()+now.month.toString();
                    _storeDatatoFirebase(idS,nameS,_score,_date,_higestScore,_title,cityS,_achivement);
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 20),
    );


    // Custom Toast Position

  }

  void customToastShow() {
    fToast.removeCustomToast();
      _score=0;

    _rollTheDice();
  }

  void _saveLastScore(int score) async {


      final prefs = await SharedPreferences.getInstance();
      final key = 'my_int_key';
      final value = score;
      prefs.setInt(key, value);
      print('saved $value');
  }
  _readHigestScore() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
        _higestScore=value;


  }

  void _storeDatatoFirebase(id, name, int score, date, int higestScore, title, city, achivement) {
    Map<String,dynamic> data={"id":id,"name":name,"title":title,"city":city,"score":score,"higest":higestScore,"date":date,"achivement":achivement};
    FirebaseFirestore.instance.collection("players").add(data);

    
  }


  Future<String> fetchUsersData() async {
    final prefs = await SharedPreferences.getInstance();

    nameS = prefs.getString("nm")!;
    idS= prefs.getString("id")!;
    cityS = prefs.getString("ct")!;
    return nameS;
  }


}








