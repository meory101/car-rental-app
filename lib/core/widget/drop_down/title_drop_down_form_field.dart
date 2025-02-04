import 'package:flutter/cupertino.dart';

import '../../resource/color_manager.dart';

import '../text/app_text_widget.dart';
import 'NameAndId.dart';
import 'drop_down_form_field.dart';


class TitleDropDownFormFieldWidget extends StatelessWidget {
  final String title, hint;
  final List<NameAndId> options;
  final String? Function(NameAndId?)? validator;
  final Function(NameAndId?)? onChanged;
  final Color? hintColor;

  const TitleDropDownFormFieldWidget(
      {super.key,
      required this.hint,
        this.hintColor,
      required this.title,
         this.validator,
        this.onChanged,
      required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColorManager.textAppColor,
        ),
        SizedBox(
          height: 16
        ),
        DropDownFormFieldWidget(
          hintFontColor: hintColor,
          options: options, hint: hint,validator: validator,onChanged: onChanged,)
      ],
    );
  }
}
