import 'package:basic_api_riverpod/ui/screens/widgets/table_of_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuiltInAnimationPage extends StatefulWidget {
  const BuiltInAnimationPage({super.key});

  @override
  State<BuiltInAnimationPage> createState() => _BuiltInAnimationPageState();
}

class _BuiltInAnimationPageState extends State<BuiltInAnimationPage> {
  double _width = 200.0;
  double _height = 200.0;

  Color _color = Colors.purple;
  double _opacity = 1;

  bool _isAnimated = false; // Flag to track animation state
  bool _isHidden = false; // Flag to track hidden animation state

  void _hideTextAnimation() {
    _isHidden = !_isHidden;
    if (_isHidden) {
      _opacity = 0;
    } else {
      _opacity = 1;
    }
    setState(() {});
  }

  void _toggleAnimation() {
    setState(() {
      _isAnimated = !_isAnimated;
      if (_isAnimated) {
        _width = 400.0;
        _height = 400.0;
        _color = Colors.blue;
      } else {
        _width = 200.0;
        _height = 200.0;
        _color = Colors.purple;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TableOfContent(inBuiltinPage: true),
            IconButton(
                onPressed: _toggleAnimation,
                icon: Icon(
                  _isAnimated ? Icons.pause : Icons.play_arrow,
                  size: 50,
                )),
            AnimatedContainer(
              duration: const Duration(seconds: 3),
              curve: Curves.easeInOut,
              // Animation curve for smooth transition
              width: _width,
              height: _height,
              color: _color,
              child: Center(
                child: const Text(
                  'Animated Container',
                  style: TextStyle(color: Colors.white),
                ),
              ), // Center content
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: AnimatedOpacity(
                  opacity: _opacity,
                  child: TextButton(
                      onPressed: _hideTextAnimation, child: Text("Hide Me")),
                  duration: Duration(seconds: 2)),
            )
          ],
        ),
      ),
    );
  }
}
