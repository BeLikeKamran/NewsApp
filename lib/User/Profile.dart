import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/MainPages/TabBar.dart';
import 'package:myapp/User/Login.dart';
import 'package:myapp/User/Premium.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    final user = FirebaseAuth.instance.currentUser;

    if (FirebaseAuth.instance.currentUser == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) => AlertDialog(
                                title: Text("Attention"),
                                content: Text(
                                    "You need to upgrade to premium before uploading profile picture!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    Premium()));
                                      },
                                      child: Text("Upgrade To Premium"))
                                ],
                              ));
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        "https://image.flaticon.com/icons/png/512/64/64572.png",
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 21,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.enhanced_encryption_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 40,
                        child: Center(
                          child: Text("User:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 40,
                        child: Center(
                          child: Text("Email:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton.icon(
                        icon: Icon(Icons.login),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (builder) => Login()));
                        },
                        label: Text("Login"),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
            future: users
                .doc(
                  user.email,
                )
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 4,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Waiting",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      )),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  'https://image.flaticon.com/icons/png/512/64/64572.png',
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  height: 40,
                                  child: Center(
                                    child: Text(data["username"],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  height: 40,
                                  child: Center(
                                    child: Text(data["email"],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                OutlinedButton.icon(
                                  icon: Icon(Icons.logout),
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (builder) => TabBarPage()),
                                        (route) => false);
                                  },
                                  label: Text("LogOut"),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blueAccent),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
      );
    }
  }
}
