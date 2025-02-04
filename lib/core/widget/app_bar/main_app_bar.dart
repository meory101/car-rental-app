import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../resource/color_manager.dart';

import '../text/app_text_widget.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.title,this.onPop});

  final String title;
  final void Function()? onPop;

  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColorManager.white,
      automaticallyImplyLeading: false,
      title:
      Row(
        children: [
          InkWell(
            onTap: () {
              if(onPop!=null){
                onPop!();
              }

              else{
                Navigator.pop(context);
              }
            },
            child:Icon(Icons.arrow_back)
          ),
          SizedBox(
            width: 16,
          ),
          AppTextWidget(
            text: title ,
            fontSize: 18,
            color: AppColorManager.mainColor,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      elevation: 0,
    );
  }
}
