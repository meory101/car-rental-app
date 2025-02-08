import 'package:car_rental_app/core/resource/size_manager.dart';
import 'package:car_rental_app/core/widget/text/app_text_widget.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';

import '../models/cars_response_entity.dart';
import 'car_card.dart';

class CarsGridView extends StatefulWidget {
 final List<CarsResponseEntity> cars;
  const CarsGridView({super.key,required this.cars});

  @override
  State<CarsGridView> createState() => _CarsGridViewState();
}

class _CarsGridViewState extends State<CarsGridView> {
  @override
  Widget build(BuildContext context) {
    return
      widget.cars.isEmpty ?
          Padding(
            padding:  EdgeInsets.only(top: AppHeightManager.h10),
            child: AppTextWidget(text: "No Cars"),
          )
          :
      DynamicHeightGridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        builder: (context, index) {
          return CarCard(
            car: widget.cars[index],
          );
        },
        itemCount: widget.cars.length,
        crossAxisCount: 2);
  }
}
