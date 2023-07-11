import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eopl_ide/base/Colors.dart';
import 'package:eopl_ide/base/TextStyles.dart';

class StatusBar extends StatelessWidget {
  final String langText;
  final VoidCallback onLangPressed;

  const StatusBar({
    Key? key,
    required this.langText,
    required this.onLangPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double SW = MediaQuery.of(context).size.width;
    double SH = MediaQuery.of(context).size.height;
    double statusBarHeight = 26;
    double statusBarIconHeight = statusBarHeight - 6;

    return Container(
      width: SW,
      height: statusBarHeight,
      color: CupertinoColors.activeBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: statusBarHeight,
            color: Colors.green,
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/around/remote.svg",
                color: white100,
                height: statusBarIconHeight,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            "assets/icons/sidebar/source-control.svg",
            color: white100,
            height: statusBarHeight - 10,
          ),
          const SizedBox(width: 6),
          Text(
            "master",
            style: tsBlueLine,
          ),
          const SizedBox(width: 24),
          SvgPicture.asset(
            "assets/icons/around/error.svg",
            color: white100,
            height: statusBarHeight - 10,
          ),
          const SizedBox(width: 6),
          Text(
            "0",
            style: tsBlueLine,
          ),
          const Spacer(),
          Text(
            "Selected Language :",
            style: tsBlueLine,
          ),
          const SizedBox(width: 3),
          CupertinoButton(
            onPressed: onLangPressed,
            pressedOpacity: 0.6,
            padding: EdgeInsets.zero,
            child: Text(langText, style: tsBlueLine),
          ),
          const SizedBox(width: 14),
          SvgPicture.asset(
            "assets/icons/around/bell.svg",
            color: white100,
            height: statusBarHeight - 10,
          ),
          const SizedBox(width: 12)
        ],
      ),
    );
  }
}
