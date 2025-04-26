import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle styleRegular16 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 16),
    fontWeight: FontWeight.w400,
    fontFamily: 'dear-sans',
  );

  static TextStyle styleSemiBold16 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 16),
    fontWeight: FontWeight.w600,
    fontFamily: 'dear-sans',
  );

  static TextStyle styleSemiBold20 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 20),
    fontWeight: FontWeight.w600,
    fontFamily: 'dear-sans',
  );

  static TextStyle styleBold20 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 20),
    fontWeight: FontWeight.w700,
    fontFamily: 'dear-sans',
    color: Color(0xffffffff),
  );

  static TextStyle styleMedium16 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 16),
    fontWeight: FontWeight.w500,
    fontFamily: 'dear-sans',
  );

  static TextStyle styleMedium20 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 20),
    fontWeight: FontWeight.w500,
    fontFamily: 'dear-sans',
    color: Color(0xffffffff),
  );

  static TextStyle styleRegular20 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 20),
    fontWeight: FontWeight.w400,
    fontFamily: 'dear-sans',
    color: Color(0xffffffff),
  );

  static TextStyle styleRegular30 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 30),
    fontWeight: FontWeight.w400,
    fontFamily: 'dear-sans',
    color: Color(0xffffffff),
  );

  static TextStyle styleSemiBold18 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 18),
    fontWeight: FontWeight.w600,
    fontFamily: 'dear-sans',
  );
  static TextStyle styleMedium18 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 18),
    fontWeight: FontWeight.w500,
    fontFamily: 'dear-sans',
  );

  static TextStyle styleSemiBold24 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 24),
    fontWeight: FontWeight.w600,
    fontFamily: 'dear-sans',
  );

  static TextStyle styleBold16 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 16),
    fontWeight: FontWeight.w700,
    fontFamily: 'dear-sans',
  );

  static TextStyle styleRegular12 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 12),
    fontWeight: FontWeight.w400,
    fontFamily: 'dear-sans',
    color: Color(0xffAAAAAA),
  );

  static TextStyle styleRegular14 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 14),
    fontWeight: FontWeight.w400,
    fontFamily: 'dear-sans',
    color: Color(0xffAAAAAA),
  );

  static TextStyle styleMedium14 = TextStyle(
    fontSize: getResponsiveFontSize(fontSize: 14),
    fontWeight: FontWeight.w500,
    fontFamily: 'dear-sans',
    color: Color(0xffAAAAAA),
  );
}

double getResponsiveFontSize({required double fontSize}) {
  double scaleFactor = getScaleFactor();
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor() {
  double width =
      MediaQuery.sizeOf(AppConstants.navigatorKey.currentContext!).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
