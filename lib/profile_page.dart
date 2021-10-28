import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:random_number_game/main.dart';
import 'package:random_number_game/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_widget/custom_drawer.dart';
import 'custom_widget/google_login_controller.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String name="Bot User",userId="10",city="Dhaka";
  TextEditingController nameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  final controler= Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Your Profile'),centerTitle: true ,  leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('img/pp.jpg',
                            height: 80.0,
                            width: 80.0,
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
                    ),],),
                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
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
                            hintText: 'YOUR CITY',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 58),
                        child: RaisedButton(
                          onPressed: (){

                            name=nameController.text;
                            userId=idController.text;
                            city=cityController.text;
                            saveDataToSharedPref(name,userId,city);
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
                                  )
                              ),
                            );

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
                                  maxWidth: 200.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(color: Colors.white, fontSize: 15),
                              ),

                            ),
                          ),
                        ),
                      ),
                      Center(
                        child:Obx((){
                          if(controler.googleAccount.value == null)
                          {
                            return buildLoginButton();
                          }
                          else
                          {
                            return buildProfileView();
                          }
                        }),
                      )],
                  ),
                )



              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildProfileView() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: Image.network(controler.googleAccount.value?.photoUrl ?? '').image,
          radius: 60,
        ),
        Text(controler.googleAccount.value?.displayName ?? ''),
        Text(controler.googleAccount.value?.email ?? ''),
      ],
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(onPressed: (){
      controler.login();


    }, child: Text('Google'),
    );
  }




  void saveDataToSharedPref(String name, String userId, String city) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("nm", name);
    sharedPreferences.setString("id", userId);
    sharedPreferences.setString("ct", city);
    print('address saved');



  }







}