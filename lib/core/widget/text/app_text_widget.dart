import 'package:flutter/material.dart';

import '../../resource/color_manager.dart';

class AppTextWidget extends StatefulWidget {
  final String text;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final Color? decorationColor;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const AppTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.height,
    this.fontWeight,
    this.fontStyle,
    this.color = AppColorManager.textAppColor,
    this.decorationColor,
    this.textDecoration,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.padding,
    this.onTap,
  });

  @override
  State<AppTextWidget> createState() => _AppTextWidgetState();
}

class _AppTextWidgetState extends State<AppTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Text(
          widget.text,
          maxLines: widget.maxLines,
          overflow: widget.overflow ?? TextOverflow.ellipsis,
          softWrap: widget.softWrap,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          style: TextStyle(
            letterSpacing: -0.4,
            fontSize: widget.fontSize ??13,
            fontWeight: widget.fontWeight,
            color: widget.color,
            decoration: widget.textDecoration,
            decorationColor: widget.decorationColor,
            height: widget.height,
          ),
        ),
      ),
    );
  }
}
