import 'package:flutter/material.dart';

class Premium extends StatefulWidget {
  const Premium({Key key}) : super(key: key);

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sorry :(",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Premium service is not available",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
