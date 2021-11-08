import 'package:flutter/material.dart';
import 'package:random_number_game/pages/player_dashboard.dart';
import '../pages/contact_page.dart';
import '../pages/profile_page.dart';
class CustomDrawer2 extends StatefulWidget {

  @override
  _CustomDrawer2State createState() => _CustomDrawer2State();
}

class _CustomDrawer2State extends State<CustomDrawer2> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Rafid Tawhid"),
          accountEmail:
          Text("rafid@pencilbox.edu.bd"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              "PB",
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {},
        ),
        // ListTile(
        //   leading: Icon(Icons.settings),
        //   title: Text("My Profile"),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) =>
        //                 ProfilePage()));
        //   },
        // ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Players Profile"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PlayerDashboard()));
          },
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text("Contact Us"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ContactPage()));
          },
        ),
      ],
    );
  }


}
