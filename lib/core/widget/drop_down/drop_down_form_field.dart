  import 'package:car_rental_app/core/resource/font_manager.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import '../../resource/color_manager.dart';
import '../text/app_text_widget.dart';
  import 'NameAndId.dart';

  class DropDownFormFieldWidget extends StatefulWidget {
    const DropDownFormFieldWidget({
      super.key,
      required this.options,
      required this.hint,
      this.hintFontColor,
      this.hintFontSize,
      this.hintFontWeight,
      this.reset,
      this.validator,
      this.iconColor,
      this.width,
      this.iconSize,
      this.borderColor,
      this.value,
      this.onChanged,
    });

    final List<NameAndId> options;
    final String hint;
    final bool? reset;
    final Color? hintFontColor;
    final FontWeight? hintFontWeight;
    final double? hintFontSize;
    final NameAndId? value;
    final Color? borderColor;
    final double? width;
    final double? iconSize;
    final Color? iconColor;
    final String? Function(NameAndId?)? validator;
    final Function(NameAndId?)? onChanged;

    @override
    State<DropDownFormFieldWidget> createState() => _DropDownFormFieldWidgetState();
  }

  class _DropDownFormFieldWidgetState extends State<DropDownFormFieldWidget> {
    NameAndId? nameAndIdObject;

    @override
    void didUpdateWidget(covariant DropDownFormFieldWidget oldWidget) {
      super.didUpdateWidget(oldWidget);
      if (oldWidget.options != widget.options) {
        setState(() {
          nameAndIdObject = null;
        });
      }
    }

    GlobalKey<FormFieldState> dropDownKey = GlobalKey<FormFieldState>();

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          DropdownButtonFormField<NameAndId>(

            validator: widget.validator,
            icon: const SizedBox(),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize:FontSizeManager.fs14
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),

              suffixIcon: Padding(
                padding: const EdgeInsets.all(19.0),
                child: SizedBox(
                  height: 10,
                  width: 10,
                  // child: SvgPicture.asset(AppIconManager.arrowMenuDown),
                ),
              ),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(color: AppColorManager.lightGreyOpacity6),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(color: AppColorManager.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(color: AppColorManager.lightGreyOpacity6),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(color: AppColorManager.lightGreyOpacity6),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(color: AppColorManager.lightGreyOpacity6),
              ),
            ),
            borderRadius: BorderRadius.circular(10,),
            key: dropDownKey,
            isExpanded: true,
            style: TextStyle(
              fontWeight: widget.hintFontWeight ?? FontWeight.w400,
              // fontFamily: FontFamilyManager.cairo,
              color: AppColorManager.textAppColor,
              fontSize: FontSizeManager.fs15,
            ),
            items: widget.options
                .map((option) => DropdownMenuItem<NameAndId>(
              value: option,
              child: Padding(
                padding:  EdgeInsets.zero, // Add padding
                child: AppTextWidget(
                  color: AppColorManager.black,
                  text: option.name,
                  fontSize: FontSizeManager.fs14,
                ),
              ),
            ))
                .toList(),
            hint: AppTextWidget(
              text: widget.hint,
              fontSize: widget.hintFontSize ?? FontSizeManager.fs15,
              overflow: TextOverflow.visible,
              color: widget.hintFontColor ?? AppColorManager.grey,
            ),
            onChanged: (value) {
              setState(() {
                nameAndIdObject = value;
              });
              widget.onChanged!(value);
            },
          ),
        ],
      );
    }
  }