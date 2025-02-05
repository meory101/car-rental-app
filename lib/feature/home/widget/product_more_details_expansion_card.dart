import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/size_manager.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/resource/icon_manager.dart';
import '../../../../core/widget/text/app_text_widget.dart';
import 'expansion_list.dart';


class ProductMoreDetailsExpansionCard extends StatefulWidget {
  const ProductMoreDetailsExpansionCard({super.key});

  @override
  State<ProductMoreDetailsExpansionCard> createState() =>
      _ProductMoreDetailsExpansionCardState();
}

class _ProductMoreDetailsExpansionCardState
    extends State<ProductMoreDetailsExpansionCard> {

  bool isOrderItemExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(AppRadiusManager.r15),
          boxShadow: const [
            BoxShadow(
              color: AppColorManager.shadow,
              blurRadius: 2,
              spreadRadius: 0,
              offset:
              // changes position of shadow
              Offset(3, 5),
            ),
          ]),
      child: OrderItemExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            isOrderItemExpanded = isExpanded;
          });
        },
        children: [
          OrderItemsExpansionPanel(

              canTapOnHeader: true,
              hasIcon: false,

              isExpanded: isOrderItemExpanded,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppWidthManager.w3Point8,
                      right: AppWidthManager.w3Point8,
                      bottom: AppHeightManager.h3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "Car Model",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextWidget(
                        text: "BMW",
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: AppHeightManager.h4point4,
                      ),
                      AppTextWidget(
                        text: "Car Brand",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextWidget(
                        text:"Brand",
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                      SizedBox(
                        height: AppHeightManager.h4point4,
                      ),
                      AppTextWidget(
                        text: "Description",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextWidget(
                        text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),


                    ],
                  ),
                ),
              ),
              headerBuilder:
                  (BuildContext context, bool isExpanded) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppWidthManager.w3Point8,
                      vertical: AppHeightManager.h2),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        text: "Car Details",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(isOrderItemExpanded == true ? Icons
                          .keyboard_arrow_up_sharp :Icons.keyboard_arrow_down)
                      // SvgPicture.asset(isOrderItemExpanded == true
                      //     ? AppIconManager.arrowMenuUp
                      //     : AppIconManager.arrowMenuDown)
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
