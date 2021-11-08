import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_number_game/controllers/login_controller.dart';

// class FacebookLoginPage extends StatefulWidget {
//   static const String routeName='/fb_loginPage';
//   @override
//   _FacebookLoginPageState createState() => _FacebookLoginPageState();
// }
//
//
// class _FacebookLoginPageState extends State<FacebookLoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login App"),
//         centerTitle: true,
//         backgroundColor: Colors.redAccent,
//       ),
//
//       // body of our ui
//
//       body: loginUI(),
//     );
//   }
//
//   // creating a function loginUI
//
//   loginUI() {
//     // loggedINUI
//     // loginControllers
//
//     return Consumer<LoginController>(builder: (context, model, child) {
//       // if we are already logged in
//       if (model.userDetails != null) {
//         return Center(
//           child: loggedInUI(model),
//         );
//       } else {
//         return loginControllers(context);
//       }
//     });
//   }
//
//   loggedInUI(LoginController model) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//
//       // our ui will have 3 children, name, email, photo , logout button
//
//       children: [
//         CircleAvatar(
//           backgroundImage:
//           Image.network(model.userDetails!.photoUrl ?? "").image,
//           radius: 50,
//         ),
//
//         Text(model.userDetails!.displayName ?? ""),
//         Text(model.userDetails!.email ?? ""),
//
//         // logout
//         ActionChip(
//             avatar: Icon(Icons.logout),
//             label: Text("Logout"),
//             onPressed: () {
//               Provider.of<LoginController>(context, listen: true).logout();
//             })
//       ],
//     );
//   }
//
//   loginControllers(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//               child: Image.asset(
//                 "assets/google.png",
//                 width: 240,
//               ),
//               onTap: () {
//                 Provider.of<LoginController>(context, listen: false)
//                     .googleLogin();
//
//               }),
//           SizedBox(
//             height: 10,
//           ),
//           GestureDetector(
//               child: Image.asset(
//                 "assets/fb.png",
//                 width: 240,
//               ),
//               onTap: () {
//                 Provider.of<LoginController>(context, listen: false)
//                     .facebooklogin();
//               }),
//         ],
//       ),
//     );
//   }
// }
