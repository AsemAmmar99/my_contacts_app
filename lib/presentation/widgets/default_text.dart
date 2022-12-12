import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  const DefaultText({Key? key,
    required this.text,
    this.overflow,
    this.color,
    this.textAlign,
    this.fontSize,
    this.maxLines,
    this.fontStyle,
    this.fontWeight,
    this.textStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: textStyle != null
      ? textStyle!.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize
      )
          : TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
    );
  }
}
