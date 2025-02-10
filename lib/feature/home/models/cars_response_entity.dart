import 'dart:convert';

List<CarsResponseEntity> carsResponseEntityListFromJson(String str) =>
    List<CarsResponseEntity>.from(json.decode(str).map((x) => CarsResponseEntity.fromJson(x)));

String carsResponseEntityListToJson(List<CarsResponseEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CarsResponseEntity carsResponseEntityFromJson(String str) => CarsResponseEntity.fromJson(json.decode(str));

String carsResponseEntityToJson(CarsResponseEntity data) => json.encode(data.toJson());

class CarsResponseEntity {
  CarsResponseEntity({
    this.idCar,
    this.brand,
    this.model,
    this.description,
    this.category,
    this.isAvailableDaily,
    this.isAvailableMonthly,
    this.isAvailableYearly,
    this.dailyRentPrice,
    this.monthlyRentPrice,
    this.yearlyRentPrice,
    this.image1,
    this.image2,
    this.image3,
    this.status,
    this.createdAt,
  });

  num? idCar;
  String? brand;
  String? model;
  String? description;
  num? category;
  bool? isAvailableDaily;
  bool? isAvailableMonthly;
  bool? isAvailableYearly;
  num? dailyRentPrice;
  num? monthlyRentPrice;
  num? yearlyRentPrice;
  String? image1;
  dynamic image2;
  dynamic image3;
  num? status;
  String? createdAt;

  factory CarsResponseEntity.fromJson(Map<String, dynamic> json) => CarsResponseEntity(
    idCar: json['id_car'],
    brand: json['brand'],
    model: json['model'],
    description: json['description'],
    category: json['category'],
    isAvailableDaily: json['is_available_daily'],
    isAvailableMonthly: json['is_available_monthly'],
    isAvailableYearly: json['is_available_yearly'],
    dailyRentPrice: json['daily_rent_price'],
    monthlyRentPrice: json['monthly_rent_price'],
    yearlyRentPrice: json['yearly_rent_price'],
    image1: json['image1'],
    image2: json['image2'],
    image3: json['image3'],
    status: json['status'],
    createdAt: json['created_at'],
  );

  /// Convert Dart Object to JSON
  Map<String, dynamic> toJson() => {
    'id_car': idCar,
    'brand': brand,
    'model': model,
    'description': description,
    'category': category,
    'is_available_daily': isAvailableDaily,
    'is_available_monthly': isAvailableMonthly,
    'is_available_yearly': isAvailableYearly,
    'daily_rent_price': dailyRentPrice,
    'monthly_rent_price': monthlyRentPrice,
    'yearly_rent_price': yearlyRentPrice,
    'image1': image1,
    'image2': image2,
    'image3': image3,
    'status': status,
    'created_at': createdAt,
  };

  /// Clone the object with new values
  CarsResponseEntity copyWith({
    num? idCar,
    String? brand,
    String? model,
    String? description,
    num? category,
    bool? isAvailableDaily,
    bool? isAvailableMonthly,
    bool? isAvailableYearly,
    num? dailyRentPrice,
    num? monthlyRentPrice,
    num? yearlyRentPrice,
    String? image1,
    dynamic image2,
    dynamic image3,
    num? status,
    String? createdAt,
  }) =>
      CarsResponseEntity(
        idCar: idCar ?? this.idCar,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        description: description ?? this.description,
        category: category ?? this.category,
        isAvailableDaily: isAvailableDaily ?? this.isAvailableDaily,
        isAvailableMonthly: isAvailableMonthly ?? this.isAvailableMonthly,
        isAvailableYearly: isAvailableYearly ?? this.isAvailableYearly,
        dailyRentPrice: dailyRentPrice ?? this.dailyRentPrice,
        monthlyRentPrice: monthlyRentPrice ?? this.monthlyRentPrice,
        yearlyRentPrice: yearlyRentPrice ?? this.yearlyRentPrice,
        image1: image1 ?? this.image1,
        image2: image2 ?? this.image2,
        image3: image3 ?? this.image3,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
}
