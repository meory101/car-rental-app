import 'dart:convert';
/// cars : [{"id_car":2,"owner_office":null,"owner_customer":"mk-mk","status":"متاحة","brand":"ل","model":"بيس","description":"بسي","is_available_daily":true,"is_available_monthly":true,"is_available_yearly":true,"daily_rent_price":100.0,"monthly_rent_price":100.0,"yearly_rent_price":100.0,"is_for_sale":false,"sale_price":null,"image1":"http://192.168.106.164:8000/media/cars/56e2690ee8694f83941bdf10cb926308.jpg","image2":"http://192.168.106.164:8000/media/cars/9e937354525440dfa97a86a160213ff5.jpg","image3":"http://192.168.106.164:8000/media/cars/2e369610d6ab46bf88cc946e4d9032a2.jpg","created_at":"2025-05-16T22:57:02.933428Z","category":1},{"id_car":1,"owner_office":"mk","owner_customer":null,"status":"متاحة","brand":"بورش","model":"توربو S","description":"أيقونة السيارات الرياضية الألمانية، تأتي بمحرك 6 أسطوانات سعة 3.8 لتر مع شاحن توربيني مزدوج، يولد قوة 640 حصانًا، وتتميز بأدائها المتوازن وتصميمها الكلاسيكي.","is_available_daily":true,"is_available_monthly":true,"is_available_yearly":true,"daily_rent_price":100.0,"monthly_rent_price":2500.0,"yearly_rent_price":30000.0,"is_for_sale":false,"sale_price":null,"image1":null,"image2":null,"image3":null,"created_at":"2025-05-16T17:03:33.904946Z","category":1},{"id_car":3,"owner_office":"mk","owner_customer":null,"status":"حجز مؤقت للأجار","brand":"ل","model":"بيس","description":"بسي","is_available_daily":true,"is_available_monthly":true,"is_available_yearly":true,"daily_rent_price":100.0,"monthly_rent_price":100.0,"yearly_rent_price":100.0,"is_for_sale":true,"sale_price":500.0,"image1":"http://192.168.106.164:8000/media/cars/7084220fab09460e8a1b7bd0478fa29c.jpg","image2":"http://192.168.106.164:8000/media/cars/cbb1d5c039db41588a8e9fa6fb7f1a0e.jpg","image3":"http://192.168.106.164:8000/media/cars/2441be46dff746adaa642a79342125a0.jpg","created_at":"2025-05-16T23:07:13.218140Z","category":1}]
/// cars_category : [{"id_car_type":1,"name":"اقتصادية"}]

CarListResponseEntity carListResponseEntityFromJson(String str) => CarListResponseEntity.fromJson(json.decode(str));
String carListResponseEntityToJson(CarListResponseEntity data) => json.encode(data.toJson());
class CarListResponseEntity {
  CarListResponseEntity({
      List<CarsResponseEntity>? cars, 
      List<CarsCategory>? carsCategory,}){
    _cars = cars;
    _carsCategory = carsCategory;
}

  CarListResponseEntity.fromJson(dynamic json) {
    if (json['cars'] != null) {
      _cars = [];
      json['cars'].forEach((v) {
        _cars?.add(CarsResponseEntity.fromJson(v));
      });
    }
    if (json['cars_category'] != null) {
      _carsCategory = [];
      json['cars_category'].forEach((v) {
        _carsCategory?.add(CarsCategory.fromJson(v));
      });
    }
  }
  List<CarsResponseEntity>? _cars;
  List<CarsCategory>? _carsCategory;
CarListResponseEntity copyWith({  List<CarsResponseEntity>? cars,
  List<CarsCategory>? carsCategory,
}) => CarListResponseEntity(  cars: cars ?? _cars,
  carsCategory: carsCategory ?? _carsCategory,
);
  List<CarsResponseEntity>? get cars => _cars;
  List<CarsCategory>? get carsCategory => _carsCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cars != null) {
      map['cars'] = _cars?.map((v) => v.toJson()).toList();
    }
    if (_carsCategory != null) {
      map['cars_category'] = _carsCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id_car_type : 1
/// name : "اقتصادية"

CarsCategory carsCategoryFromJson(String str) => CarsCategory.fromJson(json.decode(str));
String carsCategoryToJson(CarsCategory data) => json.encode(data.toJson());
class CarsCategory {
  CarsCategory({
      num? idCarType, 
      String? name,}){
    _idCarType = idCarType;
    _name = name;
}

  CarsCategory.fromJson(dynamic json) {
    _idCarType = json['id_car_type'];
    _name = json['name'];
  }
  num? _idCarType;
  String? _name;
CarsCategory copyWith({  num? idCarType,
  String? name,
}) => CarsCategory(  idCarType: idCarType ?? _idCarType,
  name: name ?? _name,
);
  num? get idCarType => _idCarType;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_car_type'] = _idCarType;
    map['name'] = _name;
    return map;
  }

}

/// id_car : 2
/// owner_office : null
/// owner_customer : "mk-mk"
/// status : "متاحة"
/// brand : "ل"
/// model : "بيس"
/// description : "بسي"
/// is_available_daily : true
/// is_available_monthly : true
/// is_available_yearly : true
/// daily_rent_price : 100.0
/// monthly_rent_price : 100.0
/// yearly_rent_price : 100.0
/// is_for_sale : false
/// sale_price : null
/// image1 : "http://192.168.106.164:8000/media/cars/56e2690ee8694f83941bdf10cb926308.jpg"
/// image2 : "http://192.168.106.164:8000/media/cars/9e937354525440dfa97a86a160213ff5.jpg"
/// image3 : "http://192.168.106.164:8000/media/cars/2e369610d6ab46bf88cc946e4d9032a2.jpg"
/// created_at : "2025-05-16T22:57:02.933428Z"
/// category : 1

CarsResponseEntity carsFromJson(String str) => CarsResponseEntity.fromJson(json.decode(str));
String carsToJson(CarsResponseEntity data) => json.encode(data.toJson());
class CarsResponseEntity {
  CarsResponseEntity({
      num? idCar, 
      dynamic ownerOffice, 
      String? ownerCustomer, 
      String? status, 
      String? brand, 
      String? model, 
      String? description, 
      bool? isAvailableDaily, 
      bool? isAvailableMonthly, 
      bool? isAvailableYearly, 
      num? dailyRentPrice, 
      num? monthlyRentPrice, 
      num? yearlyRentPrice, 
      bool? isForSale, 
      dynamic salePrice, 
      String? image1, 
      String? image2, 
      String? image3, 
      String? createdAt, 
      num? category,}){
    _idCar = idCar;
    _ownerOffice = ownerOffice;
    _ownerCustomer = ownerCustomer;
    _status = status;
    _brand = brand;
    _model = model;
    _description = description;
    _isAvailableDaily = isAvailableDaily;
    _isAvailableMonthly = isAvailableMonthly;
    _isAvailableYearly = isAvailableYearly;
    _dailyRentPrice = dailyRentPrice;
    _monthlyRentPrice = monthlyRentPrice;
    _yearlyRentPrice = yearlyRentPrice;
    _isForSale = isForSale;
    _salePrice = salePrice;
    _image1 = image1;
    _image2 = image2;
    _image3 = image3;
    _createdAt = createdAt;
    _category = category;
}

  CarsResponseEntity.fromJson(dynamic json) {
    _idCar = json['id_car'];
    _ownerOffice = json['owner_office'];
    _ownerCustomer = json['owner_customer'];
    _status = json['status'];
    _brand = json['brand'];
    _model = json['model'];
    _description = json['description'];
    _isAvailableDaily = json['is_available_daily'];
    _isAvailableMonthly = json['is_available_monthly'];
    _isAvailableYearly = json['is_available_yearly'];
    _dailyRentPrice = json['daily_rent_price'];
    _monthlyRentPrice = json['monthly_rent_price'];
    _yearlyRentPrice = json['yearly_rent_price'];
    _isForSale = json['is_for_sale'];
    _salePrice = json['sale_price'];
    _image1 = json['image1'];
    _image2 = json['image2'];
    _image3 = json['image3'];
    _createdAt = json['created_at'];
    _category = json['category'];
  }
  num? _idCar;
  dynamic _ownerOffice;
  String? _ownerCustomer;
  String? _status;
  String? _brand;
  String? _model;
  String? _description;
  bool? _isAvailableDaily;
  bool? _isAvailableMonthly;
  bool? _isAvailableYearly;
  num? _dailyRentPrice;
  num? _monthlyRentPrice;
  num? _yearlyRentPrice;
  bool? _isForSale;
  dynamic _salePrice;
  String? _image1;
  String? _image2;
  String? _image3;
  String? _createdAt;
  num? _category;
CarsResponseEntity copyWith({  num? idCar,
  dynamic ownerOffice,
  String? ownerCustomer,
  String? status,
  String? brand,
  String? model,
  String? description,
  bool? isAvailableDaily,
  bool? isAvailableMonthly,
  bool? isAvailableYearly,
  num? dailyRentPrice,
  num? monthlyRentPrice,
  num? yearlyRentPrice,
  bool? isForSale,
  dynamic salePrice,
  String? image1,
  String? image2,
  String? image3,
  String? createdAt,
  num? category,
}) => CarsResponseEntity(  idCar: idCar ?? _idCar,
  ownerOffice: ownerOffice ?? _ownerOffice,
  ownerCustomer: ownerCustomer ?? _ownerCustomer,
  status: status ?? _status,
  brand: brand ?? _brand,
  model: model ?? _model,
  description: description ?? _description,
  isAvailableDaily: isAvailableDaily ?? _isAvailableDaily,
  isAvailableMonthly: isAvailableMonthly ?? _isAvailableMonthly,
  isAvailableYearly: isAvailableYearly ?? _isAvailableYearly,
  dailyRentPrice: dailyRentPrice ?? _dailyRentPrice,
  monthlyRentPrice: monthlyRentPrice ?? _monthlyRentPrice,
  yearlyRentPrice: yearlyRentPrice ?? _yearlyRentPrice,
  isForSale: isForSale ?? _isForSale,
  salePrice: salePrice ?? _salePrice,
  image1: image1 ?? _image1,
  image2: image2 ?? _image2,
  image3: image3 ?? _image3,
  createdAt: createdAt ?? _createdAt,
  category: category ?? _category,
);
  num? get idCar => _idCar;
  dynamic get ownerOffice => _ownerOffice;
  String? get ownerCustomer => _ownerCustomer;
  String? get status => _status;
  String? get brand => _brand;
  String? get model => _model;
  String? get description => _description;
  bool? get isAvailableDaily => _isAvailableDaily;
  bool? get isAvailableMonthly => _isAvailableMonthly;
  bool? get isAvailableYearly => _isAvailableYearly;
  num? get dailyRentPrice => _dailyRentPrice;
  num? get monthlyRentPrice => _monthlyRentPrice;
  num? get yearlyRentPrice => _yearlyRentPrice;
  bool? get isForSale => _isForSale;
  dynamic get salePrice => _salePrice;
  String? get image1 => _image1;
  String? get image2 => _image2;
  String? get image3 => _image3;
  String? get createdAt => _createdAt;
  num? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_car'] = _idCar;
    map['owner_office'] = _ownerOffice;
    map['owner_customer'] = _ownerCustomer;
    map['status'] = _status;
    map['brand'] = _brand;
    map['model'] = _model;
    map['description'] = _description;
    map['is_available_daily'] = _isAvailableDaily;
    map['is_available_monthly'] = _isAvailableMonthly;
    map['is_available_yearly'] = _isAvailableYearly;
    map['daily_rent_price'] = _dailyRentPrice;
    map['monthly_rent_price'] = _monthlyRentPrice;
    map['yearly_rent_price'] = _yearlyRentPrice;
    map['is_for_sale'] = _isForSale;
    map['sale_price'] = _salePrice;
    map['image1'] = _image1;
    map['image2'] = _image2;
    map['image3'] = _image3;
    map['created_at'] = _createdAt;
    map['category'] = _category;
    return map;
  }

}