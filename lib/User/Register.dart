import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/MainPages/TabBar.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController passwordconfirm = TextEditingController();
  bool value = false;
  bool showpass = true;
  @override
  Widget build(BuildContext context) {
    //
    final a = SnackBar(
      duration: Duration(seconds: 30),
      action: SnackBarAction(
        label: "Dismiss",
        onPressed: () {},
      ),
      content: Text(emailcontroller.text +
          "   is not a valid email \nOR it is already exists"),
    );

    Future<void> register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final String username = namecontroller.text;
      final String email = emailcontroller.text;
      final String password = passwordcontroller.text;
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ));

        if (passwordcontroller.text == passwordconfirm.text) {
          db.collection("Users").doc(user.user.email).set({
            "username": username,
            "email": email,
            "password": password,
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(a);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Text(
                          "Create An Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Enter Your Name,Email/Phone Number \nAnd Password",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/d1/a6/2a/d1a62a6d8969170025f279115470e34b.jpg',
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formGlobalKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Colors.transparent,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                      validator: (name) {
                                        if (namecontroller.text.length >= 5)
                                          return null;
                                        else
                                          return 'Name must be longer than 5 characters';
                                      },
                                      controller: namecontroller,
                                      scrollPadding: EdgeInsets.all(20),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.blueAccent,
                                          size: 25,
                                        ),
                                        hintText: 'Name',
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      )))),
                          Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Colors.transparent,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                      validator: (name) {
                                        if (emailcontroller.text.length >= 5)
                                          return null;
                                        else
                                          return 'Enter a valid email';
                                      },
                                      controller: emailcontroller,
                                      scrollPadding: EdgeInsets.all(20),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.email,
                                          color: Colors.blueAccent,
                                          size: 25,
                                        ),
                                        hintText: 'Email or Phone number',
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      )))),
                          Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Colors.transparent,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                      validator: (password) {
                                        if (passwordcontroller.text.length < 8)
                                          return 'Password must be longer than 8 characters';
                                        else
                                          return null;
                                      },
                                      controller: passwordcontroller,
                                      scrollPadding: EdgeInsets.all(20),
                                      obscureText: showpass,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.security,
                                          color: Colors.blueAccent,
                                          size: 25,
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      )))),
                          Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Colors.transparent,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                      validator: (password) {
                                        if (passwordcontroller.text ==
                                            passwordconfirm.text)
                                          return null;
                                        else
                                          return 'Password is incorect';
                                      },
                                      controller: passwordconfirm,
                                      scrollPadding: EdgeInsets.all(20),
                                      obscureText: showpass,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.security,
                                          color: Colors.blueAccent,
                                          size: 25,
                                        ),
                                        suffixIcon: Checkbox(
                                            value: this.value,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.value = value;
                                                showpass = !value;
                                              });
                                            }),
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                      )))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  OutlinedButton.icon(
                    icon: Icon(Icons.app_registration),
                    onPressed: () async {
                      if (formGlobalKey.currentState.validate()) {
                        formGlobalKey.currentState.save();
                        await register();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (builder) => TabBarPage()),
                          (route) => false);
                      }
                    },
                    label: Text("Register"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
