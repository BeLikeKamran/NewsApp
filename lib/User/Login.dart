import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/MainPages/TabBar.dart';
import 'package:myapp/User/Register.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool value = false;
  bool showpass = true;

  @override
  Widget build(BuildContext context) {
    //
    final a = SnackBar(
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "Dismiss",
        onPressed: () {},
      ),
      content: Text("Enter Valid Email"),
    );
    Future<void> login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final String email = emailcontroller.text;
      final String password = passwordcontroller.text;

      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final DocumentSnapshot snapshot =
            await db.collection("Users").doc(user.user.email).get();
        // ignore: unused_local_variable
        final data = snapshot.data();
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
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(children: [
                Text(
                  "{ Welcome }",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Enter Your Email / Phone Number",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
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
                                    if (emailcontroller.text.length >= 5)
                                      return null;
                                    else
                                      return 'Enter a valid email';
                                  },
                                  controller: emailcontroller,
                                  scrollPadding: EdgeInsets.all(20),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Email or Phone number',
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.blue,
                                      size: 25,
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    border: InputBorder.none,
                                  ),
                                ))),
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
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.security,
                                        color: Colors.blue,
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
                                      hintText: 'Password',
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
                  icon: Icon(Icons.login),
                  onPressed: () async {
                    if (formGlobalKey.currentState.validate()) {
                      formGlobalKey.currentState.save();
                      await login();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => TabBarPage()));
                    }
                  },
                  label: Text("Login"),
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a User? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => Register()));
                      },
                      child: Text(' Create New Account',
                          style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
