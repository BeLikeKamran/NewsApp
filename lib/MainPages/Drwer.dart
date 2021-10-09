import 'package:flutter/material.dart';

class Drwer extends StatefulWidget {
  const Drwer({Key key}) : super(key: key);

  @override
  _DrwerState createState() => _DrwerState();
}

class _DrwerState extends State<Drwer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 120,
        child: SafeArea(
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Center(
                      child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                  )),
                ),
                ListTile(title: Text("Profile")),
                ListTile(title: Text("Register")),
                ListTile(title: Text("Login"))
              ],
            ),
          ),
        ));
  }
}
