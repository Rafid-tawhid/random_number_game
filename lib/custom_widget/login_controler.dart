import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:random_number_game/models/user_model_class.dart';

// class FbLoginControler extends ChangeNotifier{
//
//   UserDetails? userDetails;
//
//   allowUserToSignInFb()async{
//     var result=await FacebookAuth.i.login(
//       permissions: ["public_profile","email"]
//
//     );
//
//     if(result.status==LoginStatus.success)
//       {
//         final requestData=await FacebookAuth.i.getUserData(
//           fields: "email,name,picture.type(large)",
//         );
//
//         this.userDetails=new UserDetails(
//           displayName: requestData["name"],
//           email: requestData["email"],
//           photoUrl: requestData["picture"]["data"]["url"],
//         );
//         notifyListeners();
//       }
//
//   }
//   allowUsertoSignOut() async{
//     await FacebookAuth.i.logOut();
//     userDetails=null;
//     notifyListeners();
//
//   }
// }