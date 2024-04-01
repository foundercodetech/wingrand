import 'package:flutter/material.dart';
import 'package:wingrandseven/res/app_constant.dart';
import 'package:wingrandseven/res/components/dimensions.dart';

media(context){
  final height= MediaQuery.of(context).size.height;
}


final BahnschriftRegular = TextStyle(
  fontFamily: AppConstants.fontbahnschrift,
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final BahnschriftMedium = TextStyle(
  fontFamily: AppConstants.fontbahnschrift,
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

final BahnschriftBold = TextStyle(
  fontFamily: AppConstants.fontbahnschrift,
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final BahnschriftBlack = TextStyle(
  fontFamily: AppConstants.fontbahnschrift,
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
);

