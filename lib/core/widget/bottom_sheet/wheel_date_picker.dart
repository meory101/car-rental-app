import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resource/color_manager.dart';
import '../button/main_app_button.dart';
import '../text/app_text_widget.dart';


void showWheelDatePicker(
    {required BuildContext context,
      required Function(DateTime) onDateSelected}) {
  DateTime selectedDate = DateTime(DateTime.now().year - 12);
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColorManager.white,
    builder: (BuildContext builder) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColorManager.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColorManager.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CupertinoDatePicker(

                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime? pickedDate) {
                    if (pickedDate != null) {
                      selectedDate = pickedDate;
                    }
                  },
                  itemExtent: 100,

                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainAppButton(
                  width: MediaQuery.of(context).size.width / 2.6,
                  borderRadius: BorderRadius.circular(10),
                  height: 100,
                  onTap: () {
                    onDateSelected(selectedDate);
                    Navigator.of(context).pop();

                  },
                  color: AppColorManager.mainColor,
                  alignment: Alignment.center,
                  child: AppTextWidget(
                    text: "save",
                    fontSize: 16,
                    color: AppColorManager.white,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                MainAppButton(
                  width: MediaQuery.of(context).size.width / 2.6,
                  borderRadius: BorderRadius.circular(10),
                  height: 100,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  color: AppColorManager.white,
                  alignment: Alignment.center,
                  child: AppTextWidget(
                    text: "cancel",
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      );
    },
  );
}






