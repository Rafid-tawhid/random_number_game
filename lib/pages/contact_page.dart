import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_number_game/auth/firebase_auth.dart';


class ContactPage extends StatefulWidget {
  static const String routeName='/page_contact';

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  late String email, pass, name, phone;
  Widget TextFieldCustom(
      {required String hintText,
        required IconData icon,
        required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 22,
              color: Colors.orange,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black87),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.orange,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 24, color: Colors.orange),
                    ),
                  ),
                ),
                Column(
                  children: [
                    TextFieldCustom(
                      hintText: "Username",
                      controller: nameController,
                      icon: Icons.person_outline,
                    ),
                    TextFieldCustom(
                        hintText: "E-mail",
                        controller: emailController,
                        icon: Icons.mail_outline),
                    TextFieldCustom(
                        hintText: "Phone No",
                        controller: phoneController,
                        icon: Icons.phone),
                    Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                  new BorderSide(color: Colors.orange)),
                              hintText: 'Your Message',
                              helperText: 'We are listening.',
                              labelText: 'Your Message',
                              prefixIcon: const Icon(
                                Icons.message_outlined,
                                color: Colors.orange,
                              ),
                              prefixText: ' ',
                              suffixText: ' ',
                              suffixStyle:
                              const TextStyle(color: Colors.orange)),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 50,
                  width: 180,
                  child: RaisedButton(
                    onPressed: () {
                      name = nameController.text;
                      email = emailController.text;
                      phone = phoneController.text;
                      pass = passController.text;
                      final FirebaseFirestore db = FirebaseFirestore.instance;
                       final ref = db.collection('players').doc();
                       var membersIDS=FirebaseAuthService.current_user!.uid;


                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.orange,
                    child: Text(
                      "Send",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.blueAccent)
                  // ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          "Contact Information",
                          style: TextStyle(fontSize: 24, color: Colors.orange),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Text(
                                "Address:",
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "5th Floor EDB Trade Centre, 93 Kazi Nazrul Islam Ave, Dhaka 1215.",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ), //1st info
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "E-mail:",
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "info@bitbirds.com",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ), //1st info
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "Phone numbers:",
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "(+880) 1873 873 008",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "(+880) 1711 873 008",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          ),//1st info
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(Icons.facebook,color: Colors.blue,),
                            onPressed: () async {
                              const url = 'https://bitbirds.com/';
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(Icons.web,color: Colors.purple),
                            onPressed: () async {
                              const url = 'https://bitbirds.com/';
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(Icons.email,color: Colors.red),
                            onPressed: () async {
                              const url = 'https://bitbirds.com/';
                            }
                        ),
                      ),

                    ],
                  ),
                )

              ],
            ),
          ),
        ));
  }
}
