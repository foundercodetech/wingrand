import 'package:wingrandseven/res/aap_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wingrandseven/res/components/fontstyle.dart';

Widget textWidget({
  required String text,
  double ?fontSize,
  FontWeight ?fontWeight,
  Color ?color,
  TextAlign ?textAlign ,
  bool ?strikethrough,
  int? maxLines,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    // style: GoogleFonts.lato(
    //   fontSize: fontSize,
    //   fontWeight: fontWeight,
    //   color: color,
    //   decoration: strikethrough ? TextDecoration.lineThrough : null,
    // ),
    style:BahnschriftMedium.copyWith(color:color,
      fontSize: fontSize,
        fontWeight: fontWeight,
    ),
  );
}