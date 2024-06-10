import 'package:basic_api_riverpod/ui/screens/widgets/table_of_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PackageAnimationPage extends StatefulWidget {
  const PackageAnimationPage({super.key});

  @override
  State<PackageAnimationPage> createState() => _PackageAnimationPageState();
}

class _PackageAnimationPageState extends State<PackageAnimationPage> {
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableOfContent(inPackageAnimationPage: true),
            Text('Animated Text')
                .animate()
                .shake(duration: Duration(seconds: 2)),
            ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                    child: Text('Click Me'))
                .animate(target: _toggle ? 1 : 0)
                .fadeIn(curve: Curves.easeInCubic)
                .scaleXY(begin: _toggle ? 2 : 1),
            Container(
              height: 150,
              width: 150,
              color: Colors.purple,
            )
                .animate()
                .rotate(duration: Duration(milliseconds: 1000))
                .then()
                .scaleXY(begin: 3, end: 1)
                .then(duration: 200.ms)
                .rotate()
                .then(duration: 200.ms)
                .swap(builder: (context, _) {
              return Text('Animation Done ').animate().shimmer();
            }),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _toggle = !_toggle;
                });
              },
              child: Text('Click Me'),
            )
                .animate(target: _toggle ? 1 : 0)
                .scaleXY(end: 1.2, duration: Duration(milliseconds: 200))
                .then(duration: 200.ms)
                .scaleXY(end: 1.0, duration: Duration(milliseconds: 200))
          ],
        ),
      ),
    );
  }
}
