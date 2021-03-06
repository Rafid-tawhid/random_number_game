import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:random_number_game/auth/firebase_auth.dart';
import 'package:random_number_game/models/players_models.dart';
import 'package:random_number_game/pages/demo_page.dart';
import 'package:random_number_game/pages/demo_reg.dart';
import 'package:random_number_game/pages/log.dart';
import 'package:random_number_game/pages/fb_login_page.dart';
import 'package:random_number_game/pages/login_page.dart';
import 'package:random_number_game/pages/louncher_page.dart';
import 'package:random_number_game/pages/mail_login_demo.dart';
import 'package:random_number_game/pages/player_dashboard.dart';
import 'package:random_number_game/pages/profile_page.dart';
import 'package:random_number_game/pages/register_user.dart';
import 'package:random_number_game/pages/splash_screen.dart';


import 'custom_widget/custom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: HomePage(),
    ),
    initialRoute: SplashScreen.routeName,
    routes: {
      SplashScreen.routeName: (context) => SplashScreen(),
      LauncherPage.routeName: (context) => LauncherPage(),
      PlayerDashboard.routeName: (context) => PlayerDashboard(),
      ProfilePage.routeName: (context) => ProfilePage(),
      HomePage.routeName: (context) => HomePage(),
      DemoPage.routeName: (context) => DemoPage(),
      DemoReg.routeName: (context) => DemoReg(),
      LoginPage.routeName: (context) => LoginPage(),
      RegisterUser.routeName: (context) => RegisterUser(),
      Log.routeName: (context) => Log(),
    },
  ));
}

class HomePage extends StatefulWidget {
  static const String routeName = '/page_home';

  String pageName='demo';


  HomePage.name(this.pageName);

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserInfoModel _userInfoModel = UserInfoModel();
  // late Timer _timer;


  int _start = 120;
  var _score = 0;
  int _higestScore = 0 ;
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
  late QueryDocumentSnapshot user;
  bool showMsg = false;
  bool hideNumber = true;
  String _title = 'Noob';
  var _achivement = 'Concurer';
  var _date;
  final db = FirebaseFirestore.instance;

  DateTime now = DateTime.now();
  AudioPlayer player = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  String nameS = "Bot User",
      idS = "00",
      mailS = "user@",
      emailFromLogin = "email@from_user";
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
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }


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
    // _readHigestScore();

    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        title: const Text(
          "G-Game",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // print(FirebaseAuthService.current_user.toString());
                FirebaseAuthService.logoutUser();
                Navigator.pushReplacementNamed(context, SplashScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('players')
              .where('mail', isEqualTo: FirebaseAuthService.current_user!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              );
            } else
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    user = snapshot.data!.docs[index];
                    _higestScore=user['higest'];
                    // List<int> list=[];
                    // for(int i=0;i<snapshot.data!.size;i++)
                    //   {
                    //     list[i] =user['higest'];
                    //     print("O MY GOSH :"+list[1].toString());
                    //   }


                    return Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                            'Higest Score :$_higestScore',

                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  user['name'],

                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Score :$_score',
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                if (showMsg == true)
                                  Center(
                                    child: Image.asset(
                                      'img/anim2.gif',
                                      height: 150,
                                      width: 200,
                                    ),
                                  )
                                // showCongoMsg()
                                else
                                  Center(
                                    child: Image.asset(
                                      'img/anim3.gif',
                                      height: 150,
                                      width: 200,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                         if(hideNumber) Row(
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
                          if(hideNumber)Column(
                            children: [
                              const SizedBox(
                                height: 20,
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
                                              borderRadius:
                                              BorderRadius.circular(80.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xff374ABE),
                                                    Color(0xff64B6FF)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(30.0)),
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 250.0, minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "$a",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
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
                                              borderRadius:
                                              BorderRadius.circular(80.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xff374ABE),
                                                    Color(0xff64B6FF)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(30.0)),
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 250.0, minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "$b",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
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
                                              borderRadius:
                                              BorderRadius.circular(80.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xff374ABE),
                                                    Color(0xff64B6FF)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(30.0)),
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 250.0, minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "$c",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
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
                                              borderRadius:
                                              BorderRadius.circular(80.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xff374ABE),
                                                    Color(0xff64B6FF)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(30.0)),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 250.0, minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "$d",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
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
                              ElevatedButton(
                                  onPressed: _rollTheDice, child: Text("Roll")),
                            ],
                          ),

                        ],
                      ),
                    );
                  });
          }),
    );
  }

  void _rollTheDice() {
    // _fetchUserInfo();

    final player = AudioCache();
    // call this method when desired
    player.play('play.wav');

    if (_score > _higestScore) {
      _higestScore = _score;
      if (_score > 5) {
        _title = 'amature';
      }
      if (_score > 10) {
        _title = 'pro';
      }
      if (_score > 15) {
        _title = 'legend';
      }
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
    // print(list);

    a = list[0];
    b = list[1];
    c = list[2];
    d = list[3];
    print("$a" + " " "$b" + " " + "$c" + " " "$d");
  }

  checkRes(int a) {

    // print(a);
    int aa = a;
    if (aa == _sum) {
      // _rollTheDice();
      setState(() {
        showMsg = true;
        hideNumber=false;
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            showMsg = false;
            hideNumber=true;
          });
        });
      });
      _score++;
    } else {
      print("ERROR");

      showToast();
    }
  }

  showToast() {
    //buzzer sound
    final player = AudioCache();
    player.play('buzzer.wav');

    Widget toast = Container(
      height: 320,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, //                   <--- border color
            width: 1.0,
          )),
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.red,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 14.0,
                ),
                Center(
                    child: Text(
                      "Wrong Answer",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    )),
              ],
            ),
          ),
          Container(
            height: 180,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Better Luck Next Time",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    "Do You Want to Play Again ?",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  child: new Text(
                    'Exit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {

                    _higestScore = _score;
                    _date =
                    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

                    _storeDatatoFirebase();
                    fToast.removeCustomToast();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SplashScreen()));
                  },
                ),
                SizedBox(
                  width: 14.0,
                ),
                FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  child: new Text(
                    'Play',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {


                    customToastShow();
                    _date =
                    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
                    print(emailFromLogin);


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
    _score = 0;

    // _rollTheDice();
  }

  
  void _storeDatatoFirebase() {
    final docRef = FirebaseFirestore.instance.collection('players').doc();

    _userInfoModel.name = user['name'];
    _userInfoModel.mail = FirebaseAuthService.current_user?.email;
    _userInfoModel.titel = _title;
    _userInfoModel.achievement = _achivement;
    _userInfoModel.higest = _higestScore;
    _userInfoModel.date = _date;
    _userInfoModel.score = _score;
    _userInfoModel.id = docRef.id;
    // FirebaseFirestore.instance.collection('players').add(_userInfoModel.toMap());
    docRef.set(_userInfoModel.toMap());
  }

  // Future<String> fetchUsersDataFromSF() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     nameS = prefs.getString("nm")!;
  //     idS = prefs.getString("id")!;
  //     mailS = prefs.getString("mail")!;
  //     emailFromLogin = prefs.getString("emailFromLoginPage")!;
  //   });
  //   print("Get User Value from SF:" + nameS + idS + mailS);
  //   return emailFromLogin;
  // }

// void startTimer() {
//   const oneSec = const Duration(seconds: 1);
//       _timer = new Timer.periodic(
//         oneSec,
//             (Timer timer) {
//           if (_start == 0) {
//             setState(() {
//               timer.cancel();
//             });
//           } else {
//             setState(() {
//               _start--;
//             });
//           }
//         },
//       );
//
// }




}