import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
              "Favourite news is not available",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
