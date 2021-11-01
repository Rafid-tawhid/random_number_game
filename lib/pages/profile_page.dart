import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:random_number_game/main.dart';
import 'package:random_number_game/models/facebook_login_controller.dart';
import 'package:random_number_game/pages/fb_page.dart';
import 'package:random_number_game/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_widget/custom_drawer.dart';
import '../custom_widget/google_login_controller.dart';



class ProfilePage extends StatefulWidget {
  static const String routeName='/page_profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Bot User", userId = "10", city = "Dhaka";
  TextEditingController nameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  final controler = Get.put(LoginController());
  bool showInfo=true;

  String imgUrl='https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
          actions: [
            IconButton(onPressed: () async {

              Future.delayed(const Duration(milliseconds: 2000), () {
               CircularProgressIndicator();
                setState(() {
                 controler.logout();

                });

              });
              controler.logout();
            }, icon: Icon(Icons.logout))
          ],
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.network(imgUrl,
                            height: 120.0,
                            width: 120.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: nameController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'ENTER YOUR NAME',

                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: idController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'CHOSE USER ID',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: cityController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'YOUR EMAIL',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 58),
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              name = nameController.text;
                              userId = idController.text;
                              city = cityController.text;

                            });
                            saveDataToSharedPref(name, userId, city);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaterialApp(
                                        debugShowCheckedModeBanner: false,
                                        home: Scaffold(
                                          drawer: Drawer(
                                            child: CustomDrawer(),
                                          ),
                                          appBar: AppBar(
                                            title: const Text(
                                              "G-Game",
                                            ),
                                            centerTitle: true,
                                          ),
                                          body: HomePage(),
                                        ),
                                      )),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
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
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 200.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Next",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),


                      Center(
                        child: Obx(() {
                          if (controler.googleAccount.value == null) {
                            return buildLoginButton();
                          } else {
                            return buildProfileView();
                          }
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Visibility buildProfileView() {

    return Visibility(
      visible: showInfo,
      child: Column(

          children: [
            Padding(

              padding: const EdgeInsets.all(18.0),
              child: CircleAvatar(
                backgroundImage:
                    Image.network(controler.googleAccount.value?.photoUrl ?? '')
                        .image,
                radius: 45,
              ),

            ),
            Text(controler.googleAccount.value?.displayName ?? ''),
            Text(controler.googleAccount.value?.email ?? ''),
            ElevatedButton(onPressed: (){
              setState(() {
                showInfo=false;
                nameController.text=controler.googleAccount.value?.displayName ?? '';
                idController.text=controler.googleAccount.value?.id ?? '';
                cityController.text=controler.googleAccount.value?.email ?? '';
                imgUrl=controler.googleAccount.value?.photoUrl ?? '';

              });
            }, child: Text('Save Info')),


          ],


      ),
    );

  }

  Padding buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 158.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          ElevatedButton(

            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Google',
                style: TextStyle(fontSize: 14),
              ),
            ),
            onPressed: () {
              controler.login();



            },
            style: ElevatedButton.styleFrom(

              shape: CircleBorder(),
            ),
          ),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'facebook',
                style: TextStyle(fontSize: 12),
              ),
            ),
            onPressed: () async {

              //
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FbLogin()),
              );
              // await fbcontroler.login();
              // print(fbcontroler.userData.toString());

            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.indigoAccent,
            ),

          ),
        ],
      ),
    );
  }

  void saveDataToSharedPref(String name, String userId, String email) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("nm", name);
    sharedPreferences.setString("id", userId);
    sharedPreferences.setString("ct", email);
    print("saved user value to SF");
  }


}
