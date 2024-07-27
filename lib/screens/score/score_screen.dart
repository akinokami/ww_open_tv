import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/constants/dimen_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_text.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10.w),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/images/left_btn.webp",
                width: 10.w,
                height: 10.h,
              )),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: CustomText(
          text: "Score",
          fontSize: 16.sp,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kSizedBoxH20,
          Center(
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/score_board.webp"),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Best Score",
                    fontSize: 25.sp,
                  ),
                  kSizedBoxH10,
                  CustomText(
                    text: "1200",
                    fontSize: 35.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
