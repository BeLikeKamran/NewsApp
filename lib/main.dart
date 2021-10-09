import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: Center(child: Text("Welcome"))),
          body: Column(children: [
            Center(
              child: Container(
                  width: 200,
                  child: Center(
                    child: TextField(
                      decoration:
                          const InputDecoration(labelText: "Username or Email"),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  width: 200,
                  child: Center(
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Login"))
          ])),
    );
  }
}