

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number_game/auth/firebase_auth.dart';
import 'package:random_number_game/main.dart';
import 'package:random_number_game/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUser extends StatefulWidget {
  static const String routeName='/register_page';

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  late String name,email,pass;
  late String nameS,idS,emailS,errorMsg='';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();


  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Registration"),centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, LoginPage.routeName);
        }, icon: Icon(Icons.arrow_back),),),

        body: ListView(

          children: [

          Form(
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(child: Text("Registration",style: TextStyle(fontSize: 35,fontFamily: 'Cursive',letterSpacing: 2,color: Colors.deepOrange),)),
                ),
                Padding(

                  padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty ){
                        return 'This Field is required';
                      }
                      return null;
                    },
                    controller: nameController,
                    textAlign: TextAlign.left,

                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      label: Text('USER NAME'),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(

                  padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty ){
                        return 'This Field is required';
                      }
                      return null;
                    },
                    controller: emailController,
                    textAlign: TextAlign.left,

                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      label: Text('YOUR EMAIL'),
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
                  child: TextFormField(
                    controller: passController,
                    textAlign: TextAlign.left,
                    obscureText: true,
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      label: Text('Password'),

                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: FlatButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 28),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Text(
                          ' Save ',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                      }

                      setState(() {
                        email = emailController.text;
                        pass = passController.text;
                        name = nameController.text;
                      });
                       await FirebaseAuthService.signUpUser(email, pass);
                       saveDataToSharedPref(name, FirebaseAuthService.current_user!.uid, email);
                       Navigator.pushReplacementNamed(context, HomePage.routeName);
                    },
                  ),
                ),


              ],
            ),
          key: _formKey,
          ),

          ],
        ),
      )
    );
  }
  void saveDataToSharedPref(String name, String userId, String email) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("nm", name);
    sharedPreferences.setString("id", userId);
    sharedPreferences.setString("mail", email);
    print("saved user value to SF from Register Page");
  }
}
