// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//
//   loginPageUi(){
//     return Consumer<LoginControler>(builder: (context,model,child){
//       if(model.userDetails!=null){
//
//         return Center(
//          child: alreadyLogIn(model),
//         );
//       }
//       else{
//        return notLogedIn();
//       }
//     });
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white24,
//       body: loginPageUi(),
//     );
//   }
//
//   alreadyLogIn(LoginControler model) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           backgroundImage: Image.network(model.userDetails!.photoUrl ?? "").image,
//
//         ),
//         SizedBox(
//           height: 20,
//         ),
//
//         Text(model.userDetails!.displayName ?? ""),
//         SizedBox(
//           height: 10,
//         ),
//         Text(model.userDetails!.email ?? ""),
//         SizedBox(
//           height: 20,
//         ),
//         ElevatedButton(onPressed: (){
//           Provider.of<LoginControler>(context,listen: false).allowUsertoSignOut();
//         }, child: Text("Logout")),
//
//       ],
//     );
//   }
//
//   notLogedIn() {
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset('img/plus.JPG'),
//           GestureDetector(
//             child: Image.asset('img/pp.jpg',width: 240,),
//             onTap: (){
//               Provider.of<FbLoginControler>(context,listen: false).allowUserToSignInFb();
//             },
//
//           ),
//         ],
//       ),
//     );
//   }
// }
