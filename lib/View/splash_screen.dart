import 'dart:async';

import 'package:corona_info/View/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller=AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform.rotate(angle: controller.value * 2.0 * math.pi,
                  child: Container(height: 100,width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Assets/images/virus.png")
                    )
                  ),
                  ),
                  );
                },
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .06,
            ),
            const Text("Covid-Info\nTracker Application",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,height: 1.3),)
          ],
        ),
      ),
    );
  }
}
