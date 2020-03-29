import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:bethehero/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          navigateAfterSeconds: HomeScreen(),
          loaderColor: Colors.transparent,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //color: 
          decoration: BoxDecoration(
            color: Color.fromRGBO(224, 32, 65, 1),
            image: DecorationImage(
              image: AssetImage("images/splash.png")
            )
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0), 
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(),
            ),
          )
        )
      ],
    );
  }
}