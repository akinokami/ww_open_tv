import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_text.dart';

class GameIntroScreen extends StatefulWidget {
  const GameIntroScreen({super.key});

  @override
  _GameIntroScreenState createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                //Get.to(const GamePlayScreen());
              },
              child: Center(
                // child: ScaleTransition(
                //   scale: _scaleAnimation,
                child: Image.asset(
                  "assets/images/intro.webp",
                  width: 300.w,
                  height: 300.h,
                ),
                //),
              ),
            ),
          ),
          Container(
            height: 200,
            child: Column(
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: CustomText(
                    text: "Tap To Play",
                    fontSize: 40.sp,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    "assets/images/home_btn.webp",
                    width: 100.w,
                    height: 100.h,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
