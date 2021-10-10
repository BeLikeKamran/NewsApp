import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/MainPages/TabBar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:

        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors

          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: TabBarPage(),
                title: 'News App',
                theme: ThemeData(primaryColor: Colors.blue));
          }
          return Container(
            color: Colors.white,
            child: Center(
                child: Column(
              children: [
                CircularProgressIndicator(),
                Text("Something Went Wrong")
              ],
            )),
          );
        });
  }
}
