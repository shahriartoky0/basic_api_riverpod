import 'package:flutter/material.dart';

import '../controller_animation_page.dart';
import '../home_page.dart';
import '../tween_animation_page.dart';

class TableOfContent extends StatelessWidget {
  const TableOfContent({
    super.key,
    this.inBuiltinPage = false,
    this.inTweenAnimationPage = false,
    this.inControllerPage = false,
  });

  final bool inBuiltinPage;
  final bool inTweenAnimationPage;
  final bool inControllerPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade400,
      width: 250,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                if (inTweenAnimationPage == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TweenAnimationPage()));
                }
              },
              child: Text('Tween Animation Page')),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                if (inBuiltinPage == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuiltInAnimationPage()));
                }
              },
              child: Text('In Built Animation Page')),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                if (inControllerPage == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ControllerAnimationPage()));
                }
              },
              child: Text('Controller Animation Page')),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
