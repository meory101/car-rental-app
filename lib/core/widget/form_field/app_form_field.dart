import 'package:car_rental_app/core/resource/font_manager.dart';
import 'package:flutter/material.dart';
import '../../resource/color_manager.dart';


class AppTextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? enabled;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFilledSubmited;
  final Function()? editingComplete;
  final String? Function(String?)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? labelText;
  final String? initialValue;
  final TextAlignVertical? textAlignVertical;
  final Color? textColor;
  final Color? labelColor;
  final Color? borderColor;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool? outlinedBorder;
  final bool? expand;
  final bool? autoFoucs;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final bool? readOnly;
  final TextStyle? style;
  final void Function()? onTap;

  const AppTextFormField(
      {super.key,
        this.borderRadius,
        this.borderColor,
        this.minLines,
        this.filled,
        this.readOnly,
        this.enabled,
        this.suffixIcon,
        this.fillColor,
        this.expand,
        this.contentPadding,
        this.controller,
        this.obscureText,
        this.autoFoucs,
        this.onTap,
        this.validator,
        this.hintStyle,
        this.editingComplete,
        this.onChanged,
        this.textInputType,
        this.textInputAction,
        this.textAlignVertical,
        this.focusNode,
        this.labelText,
        this.style,
        this.textColor = AppColorManager.textAppColor,
        this.labelColor,
        this.onFilledSubmited,
        this.initialValue,
        this.maxLines,
        this.prefixIcon,
        this.hintText,
        this.outlinedBorder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onTap: onTap,
      key: Key(initialValue ?? ""),
      readOnly: readOnly ?? false,
      textAlignVertical: textAlignVertical,
      onFieldSubmitted: onFilledSubmited,
      cursorColor: AppColorManager.mainColor,
      validator: validator,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      onChanged: onChanged,

      autofocus: autoFoucs ?? false,
      onEditingComplete: editingComplete,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      initialValue: initialValue,
      enabled: enabled,
      expands: expand ?? false,
      decoration: InputDecoration(
        filled: filled ?? true,
        fillColor: fillColor ?? AppColorManager.white,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: hintStyle ??TextStyle(
            color: AppColorManager.grey,
            fontSize: FontSizeManager.fs15,
          fontFamily: 'Cairo',

        ),
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
        labelText: labelText,
        labelStyle: TextStyle(
            color: labelColor,
          fontSize: FontSizeManager.fs16,
          fontFamily: 'Cairo',

          fontWeight: FontWeight.bold,
            ),
        errorStyle: TextStyle(
          fontSize: 14,
          fontFamily: 'Cairo',


        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                borderRadius != null ? borderRadius! :10)),
            borderSide:   BorderSide(
              color: AppColorManager.red,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                borderRadius != null ? borderRadius! :10)),
            borderSide: BorderSide(
              color:borderColor?? AppColorManager.lightGreyOpacity6,
            )),
        disabledBorder: OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(
                borderRadius != null ? borderRadius! : 10)),
            borderSide:  BorderSide(
              color:borderColor?? Colors.transparent,
              // color: Colors.transparent,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                borderRadius != null ? borderRadius! : 10)),
            borderSide:  BorderSide(
              color:borderColor?? AppColorManager.grey,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                borderRadius != null ? borderRadius! : 10)),
            borderSide: BorderSide(
              color:borderColor?? Theme.of(context).primaryColor,
            )),
      ),
      style: style ??
          TextStyle(
              color: textColor,
              fontFamily: 'Cairo',
              fontSize: FontSizeManager.fs16,
           ),
    );
  }
}
