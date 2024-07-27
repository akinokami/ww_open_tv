import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomImageButton extends StatelessWidget {
  const CustomImageButton({super.key, required this.onTap, required this.text, this.image});
final Function() onTap;
final String text;
final String? image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 200.w,
          height: 60.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image??"assets/images/menu_btn_rect.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: CustomText(
                  text: text,

                  fontSize: 30.sp,

              ))),
    );
  }
}
