import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_rental_app/core/api/api_links.dart';
import 'package:car_rental_app/core/api/api_methods.dart';
import 'package:car_rental_app/core/resource/color_manager.dart';
import 'package:http/http.dart' as http;
import '../../core/resource/font_manager.dart';
import '../../core/resource/size_manager.dart';
import '../../core/widget/button/main_app_button.dart';
import '../../core/widget/text/app_text_widget.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dailyPriceController = TextEditingController();
  final TextEditingController _monthlyPriceController = TextEditingController();
  final TextEditingController _yearlyPriceController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();

  bool isAvailableDaily = true;
  bool isAvailableMonthly = true;
  bool isAvailableYearly = true;
  bool isForSale = false;

  String status = "1";

  File? image1;
  File? image2;
  File? image3;

  Future<void> pickImage(int imageNumber) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        if (imageNumber == 1) image1 = File(picked.path);
        if (imageNumber == 2) image2 = File(picked.path);
        if (imageNumber == 3) image3 = File(picked.path);
      });
    }
  }

  int apiStatus = -1;

  void submitForm() async {
    if (!_formKey.currentState!.validate() ||
        image1 == null ||
        image2 == null ||
        image3 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("جميع الحقول مطلوبة، بما في ذلك الصور")),
      );
      return;
    }

    final Map<String, String> data = {
      "brand": _brandController.text,
      "model": _modelController.text,
      "description": _descriptionController.text,
      // "category": _categoryController.text,
      "is_available_daily": isAvailableDaily.toString(),
      "is_available_monthly": isAvailableMonthly.toString(),
      "is_available_yearly": isAvailableYearly.toString(),
      "daily_rent_price": _dailyPriceController.text,
      "monthly_rent_price": _monthlyPriceController.text,
      "yearly_rent_price": _yearlyPriceController.text,
      "status": status,
      // "is_for_sale": isForSale.toString(),
      // "sale_price": _salePriceController.text,
    };

    List<File> files = [image1!, image2!, image3!];
    List<String> names = ["image1", "image2", "image3"];
setState(() {
  apiStatus=0;
});
    try {
     var result = await HttpMethods()
          .postWithMultiFile(ApiPostUrl.addCar, data, files, names);

     print(result);

      if (result is Map) {
        setState(() {
          apiStatus=1;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("تمت الإضافة بنجاح")));
      } else {
        setState(() {
          apiStatus=2;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("حدث خطأ: ${result}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("فشل في الإرسال: $e")));
    }
  }

  Widget buildImagePreview(File? image, int index) {
    return GestureDetector(
      onTap: () => pickImage(index),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: image != null
            ? Image.file(image, fit: BoxFit.cover)
            : Center(child: Icon(Icons.add_a_photo)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.white,
      appBar: AppBar(
        title: Text("إضافة سيارة"),
        backgroundColor: AppColorManager.white,
        surfaceTintColor: AppColorManager.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  cursorColor: AppColorManager.mainColor,
                  controller: _brandController,
                  decoration: InputDecoration(labelText: "الماركة"),
                  validator: (val) =>
                      val == null || val.isEmpty ? "مطلوب" : null,
                ),
                SizedBox(height: AppHeightManager.h1point8,),
                TextFormField(
                  cursorColor: AppColorManager.mainColor,
                  controller: _modelController,
                  decoration: InputDecoration(labelText: "الموديل"),
                  validator: (val) =>
                      val == null || val.isEmpty ? "مطلوب" : null,
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                TextFormField(
                  cursorColor: AppColorManager.mainColor,
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "الوصف"),
                  validator: (val) =>
                      val == null || val.isEmpty ? "مطلوب" : null,
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                TextFormField(
                  cursorColor: AppColorManager.mainColor,
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: "الفئة",  enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                  ) ,

                    focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                    ) ,),
                  validator: (val) =>
                      val == null || val.isEmpty ? "مطلوب" : null,
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                SwitchListTile(
                  activeColor: AppColorManager.mainColor,
                  inactiveTrackColor: AppColorManager.lightGreyOpacity6,
                  title: Text("متاحة يومياً"),
                  value: isAvailableDaily,
                  onChanged: (val) => setState(() => isAvailableDaily = val),
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                SwitchListTile(
                  activeColor: AppColorManager.mainColor,
                  inactiveTrackColor: AppColorManager.lightGreyOpacity6,
                  title: Text("متاحة شهرياً"),
                  value: isAvailableMonthly,
                  onChanged: (val) => setState(() => isAvailableMonthly = val),
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                SwitchListTile(
                  activeColor: AppColorManager.mainColor,
                  inactiveTrackColor: AppColorManager.lightGreyOpacity6,
                  title: Text("متاحة سنوياً"),
                  value: isAvailableYearly,
                  onChanged: (val) => setState(() => isAvailableYearly = val),
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                TextFormField(
                  cursorColor: AppColorManager.mainColor,
                  controller: _dailyPriceController,
                  decoration: InputDecoration(labelText: "السعر اليومي" ,   enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                  ) ,

                    focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                    ) ,),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val == null || val.isEmpty ? "مطلوب" : null,
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                TextFormField(

                  cursorColor: AppColorManager.mainColor,
                  controller: _monthlyPriceController,
                  decoration: InputDecoration(labelText: "السعر الشهري",
                      enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                      ) ,

                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                      ) ,
                      border:
                  OutlineInputBorder(
                    borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                  )),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val == null || val.isEmpty ? "مطلوب" : null,
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                TextFormField(
                  cursorColor: AppColorManager.mainColor,
                  controller: _yearlyPriceController,
                  decoration: InputDecoration(labelText: "السعر السنوي",

                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                      ) ,
                      border:
                      OutlineInputBorder(
                          borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                      )
                  ),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val == null || val.isEmpty ? "مطلوب" : null,
                ),
                SizedBox(height: AppHeightManager.h1point8,),

                SwitchListTile(
                  title: Text("متوفرة للبيع؟"),
                  value: isForSale,
                  activeColor: AppColorManager.mainColor,
                  inactiveTrackColor: AppColorManager.lightGreyOpacity6,
                  onChanged: (val) => setState(() => isForSale = val),
                ),
                if (isForSale)
                  TextFormField(
                    cursorColor: AppColorManager.mainColor,
                    controller: _salePriceController,
                    decoration: InputDecoration(labelText: "سعر البيع",  focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                    ) ,
                        border:
                        OutlineInputBorder(
                            borderSide: BorderSide(color: AppColorManager.lightGreyOpacity6)
                        )),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val == null || val.isEmpty ? "مطلوب" : null,
                  ),
                SizedBox(height: AppHeightManager.h1point8,),

                DropdownButtonFormField<String>(
                  value: status,
                  decoration: InputDecoration(labelText: "الحالة"),
                  items: [
                    DropdownMenuItem(value: "1", child: Text("متاحة")),
                    DropdownMenuItem(value: "2", child: Text("حجز مؤقت")),
                    DropdownMenuItem(value: "3", child: Text("محجوزة")),
                    DropdownMenuItem(
                        value: "4", child: Text("منتهية الصلاحية")),
                    DropdownMenuItem(value: "5", child: Text("مباعة")),
                  ],
                  onChanged: (val) => setState(() => status = val ?? "1"),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildImagePreview(image1, 1),
                    buildImagePreview(image2, 2),
                    buildImagePreview(image3, 3),
                  ],
                ),
                SizedBox(height: 24),
                Visibility(
                  visible: apiStatus == 0,
                  child: CircularProgressIndicator(color: AppColorManager.mainColor,),
                  replacement: MainAppButton(
                    onTap: () {
                      submitForm();
                    },
                    borderColor: AppColorManager.black,
                    alignment: Alignment.center,
                    width: AppWidthManager.w90,
                    height: AppHeightManager.h6,
                    color: AppColorManager.black,
                    child: AppTextWidget(
                      text: "رفع سيارة ",
                      color: AppColorManager.white,
                      fontSize: FontSizeManager.fs15,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
