import 'package:flutter/cupertino.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import 'dart:ui' as ui;


class PriceTextWidget extends StatelessWidget {
  final String price;
  final String currency;
  final bool? isOldPrice;
  final TextStyle? priceStyle;

  const PriceTextWidget(
      {super.key,
      required this.currency,
      required this.price,
        this.priceStyle,
      this.isOldPrice});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: RichText(
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: price,
              style:priceStyle?? TextStyle(
                decoration: isOldPrice == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontWeight: FontWeight.w700,
                fontSize: isOldPrice == true
                    ? FontSizeManager.fs15
                    : FontSizeManager.fs16,
                color: isOldPrice == true
                    ? AppColorManager.red
                    : AppColorManager.textAppColor,
              ),
            ),
            WidgetSpan(
                child: SizedBox(
              width: AppWidthManager.w1,
            )),
            WidgetSpan(
              child: Transform.translate(
                offset: Offset(0, -4),
                child: Text(
                  'SYP',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: FontSizeManager.fs14,
                    color: isOldPrice == true
                        ? AppColorManager.red
                        : AppColorManager.textAppColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
