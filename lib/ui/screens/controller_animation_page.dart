import 'package:basic_api_riverpod/ui/screens/widgets/table_of_content.dart';
import 'package:flutter/material.dart';

class ControllerAnimationPage extends StatefulWidget {
  const ControllerAnimationPage({super.key});

  @override
  State<ControllerAnimationPage> createState() =>
      _ControllerAnimationPageState();
}

class _ControllerAnimationPageState extends State<ControllerAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorAnimation;
  late Animation _sizeAnimation;
  bool isPopped = false;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _colorAnimation =
        ColorTween(begin: Colors.grey.shade400, end: Colors.blue.shade400)
            .animate(_animationController); // for the color
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 60,
            end: 90,
          ),
          weight: 80),
      TweenSequenceItem(tween: Tween<double>(begin: 90, end: 60), weight: 80)
    ]).animate(_animationController);
    // _animationController.forward();
    _animationController.addListener(() {
      print(_animationController.value);
      print(_colorAnimation.value);
      // putting setState () can make the animation . But builder is a better option
    });
    _animationController.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        isPopped = true;
        setState(() {});
      }
      if (status == AnimationStatus.dismissed) {
        isPopped = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableOfContent(inControllerPage: true),
            SizedBox(height: 10),
            AnimatedBuilder(
              builder: (context, _) {
                return IconButton(
                    onPressed: () {
                      isPopped
                          ? _animationController.reverse()
                          : _animationController.forward();
                    },
                    icon: Icon(
                      Icons.thumb_up,
                      color: _colorAnimation.value,
                      size: _sizeAnimation.value,
                    ));
              },
              animation: _animationController,
            ),
            Text('Click the button to Animate')
          ],
        ),
      ),
    );
  }
}
