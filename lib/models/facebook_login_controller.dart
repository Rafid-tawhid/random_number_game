
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class facebookSignInWithController with ChangeNotifier{


  static Map? userData;

  login()async{
    var result=await FacebookAuth.i.login(
      permissions: ['public_profile','email']
    );
    if(result.status==LoginStatus.success){
      print('fb login success');
      final requestData=await FacebookAuth.i.getUserData(
        fields: "email,name,picture"
      );
      userData=requestData;
      notifyListeners();
    }
  }
  logout()async{
    await FacebookAuth.i.logOut();
    userData=null;
    notifyListeners();
  }

}