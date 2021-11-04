import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number_game/auth/firebase_auth.dart';
import 'package:random_number_game/pages/register_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  static const String routeName='/loginPage';


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  late String nameS,idS,emailS,errorMsg='';
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  late String email,pass,emailFromLoginPage;

  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Login"),centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back),),),
        body: SafeArea(
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('img/anim5.gif'),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Free Free..",
                        style: TextStyle(
                            fontSize: 56, color: Colors.red, fontFamily: 'Cursive'),
                      ),
                    ),
                    Form(
                      key: _formKey,
                        child:Column(
                      children: [

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

                      ],
                    )),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("don't have an account ?"),
                          SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(child: Text("Create",style: TextStyle(color: Colors.deepOrange),),onTap: (){
                             Navigator.pushReplacementNamed(context, RegisterUser.routeName);
                            },),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(errorMsg,style: TextStyle(color: Colors.red),),
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
                              ' Play ',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                          }

                          setState(() {
                            email = emailController.text;
                            pass = passController.text;
                            loginUser(email,pass);
                          });



                        },
                      ),
                    ),



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void loginUser (String email, String pass) async {


    try{
      final user=await FirebaseAuthService.loginUser(email, pass);

      if(user!=null){
        Navigator.pushReplacementNamed(context, HomePage.routeName);
        // print("Hello : "+FirebaseAuthService.current_user!.uid);
      }
    }
    on FirebaseAuthException catch (e){
      setState(() {
        errorMsg=e.message!;
      });
    }

  }
  // void saveDataToSharedPref(String email) async {
  //   var sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setString("emailFromLoginPage", email);
  //
  // }


}
