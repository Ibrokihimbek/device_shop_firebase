
import 'package:device_shop_firebase/utils/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class MyRichText extends StatelessWidget {
  const MyRichText({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  RichText(
        text: TextSpan(
            style: MyTextStyle.sfProRegular.copyWith(
                color: const Color(0xFFFBDF00), fontSize: 18),
            text: "Already have an account? ",
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = onTap,
                text: "Sign In",
                style: MyTextStyle.sfProBold.copyWith(
                  color: const Color(0xFFFBDF00),
                  fontSize: 18,
                ),
              )
            ]));
  }
}
