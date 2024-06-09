import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TweenAnimationPage extends StatefulWidget {
  const TweenAnimationPage({super.key});

  @override
  State<TweenAnimationPage> createState() => _TweenAnimationPageState();
}

class _TweenAnimationPageState extends State<TweenAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(height: 300, width: 300, color: Colors.green),
          TweenAnimationBuilder(
            child: Text(
              "Animated Text",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 4),
            builder: (context, _val, child) {
              return Opacity(
                  opacity: _val,
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: _val * 20),
                      child: child));
            },
          )
        ],
      ),
    );
  }
}
