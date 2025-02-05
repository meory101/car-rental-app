import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';

import 'car_card.dart';

class CarsGridView extends StatefulWidget {
  const CarsGridView({super.key});

  @override
  State<CarsGridView> createState() => _CarsGridViewState();
}

class _CarsGridViewState extends State<CarsGridView> {
  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        builder: (context, index) {
          return CarCard();
        },
        itemCount: 10,
        crossAxisCount: 2);
  }
}
