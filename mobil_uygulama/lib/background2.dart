import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  final Widget child;
  const Background2({
    Key? key,
    required this.child,
    this.topImage = "assets/images/maviust.jpg",
    this.bottomImage = "assets/images/mavialt.jpg",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 100),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}