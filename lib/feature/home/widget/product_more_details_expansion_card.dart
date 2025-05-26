import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/size_manager.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/resource/icon_manager.dart';
import '../../../../core/widget/text/app_text_widget.dart';
import '../models/car_list_response_entity.dart';
import 'expansion_list.dart';


class ProductMoreDetailsExpansionCard extends StatefulWidget {
  final CarsResponseEntity car;
  const ProductMoreDetailsExpansionCard({super.key,required this.car});

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      AppTextWidget(
                        text: "حالة السيارة",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextWidget(
                        text:(widget.car.status??"").toString(),
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        color: AppColorManager.orange,
                        // color: EnumManager.statusCarColor[int.parse('${widget.car.status??0}')],

                      ),
                      SizedBox(
                        height: AppHeightManager.h4point4,
                      ),
                      AppTextWidget(
                        text: "المودل",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextWidget(
                        text: "${widget.car.model}",
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: AppHeightManager.h4point4,
                      ),
                      AppTextWidget(
                        text: "البراند",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextWidget(
                        text: "${widget.car.brand}",

                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                      SizedBox(
                        height: AppHeightManager.h4point4,
                      ),
                      AppTextWidget(
                        text: "الوصف",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextWidget(
                        text: "${widget.car.description}",
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
                        text: "تفاصيل السيارة",
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
