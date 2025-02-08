import 'dart:convert';
/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczOTA4Njc2MCwiaWF0IjoxNzM5MDAwMzYwLCJqdGkiOiJhNTJjYjA5YzdiMDI0NTYyOWU0ZDMxMDAyNWM5ZDhhZiIsInVzZXJfaWQiOjF9.eWcZiELTdtdz_VxSAY9MTD0x0E45DsJ_6ufGTd8EVXY"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM5MDA2MzYwLCJpYXQiOjE3MzkwMDAzNjAsImp0aSI6IjNiZTg5MDkzMzg3ZDRhOTNiOTRmNGRkMDZmOTRjMzA2IiwidXNlcl9pZCI6MX0.5GakgdlAF29B1WppRyRG7j4AsVQEMY-4G1sPpnzCUx4"
/// first_name : "mohammd"
/// last_name : "karrom"
/// email : "mk@gmail.com"
/// phone : "0936793213"
/// id_number : null
/// id_front_image : null
/// id_back_image : null
/// driving_license_image : null

AuthResponseEntity authResponseEntityFromJson(String str) => AuthResponseEntity.fromJson(json.decode(str));
String authResponseEntityToJson(AuthResponseEntity data) => json.encode(data.toJson());
class AuthResponseEntity {
  AuthResponseEntity({
      String? refresh, 
      String? access, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? phone, 
      dynamic idNumber, 
      dynamic idFrontImage, 
      dynamic idBackImage, 
      dynamic drivingLicenseImage,}){
    _refresh = refresh;
    _access = access;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _idNumber = idNumber;
    _idFrontImage = idFrontImage;
    _idBackImage = idBackImage;
    _drivingLicenseImage = drivingLicenseImage;
}

  AuthResponseEntity.fromJson(dynamic json) {
    _refresh = json['refresh'];
    _access = json['access'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _idNumber = json['id_number'];
    _idFrontImage = json['id_front_image'];
    _idBackImage = json['id_back_image'];
    _drivingLicenseImage = json['driving_license_image'];
  }
  String? _refresh;
  String? _access;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  dynamic _idNumber;
  dynamic _idFrontImage;
  dynamic _idBackImage;
  dynamic _drivingLicenseImage;
AuthResponseEntity copyWith({  String? refresh,
  String? access,
  String? firstName,
  String? lastName,
  String? email,
  String? phone,
  dynamic idNumber,
  dynamic idFrontImage,
  dynamic idBackImage,
  dynamic drivingLicenseImage,
}) => AuthResponseEntity(  refresh: refresh ?? _refresh,
  access: access ?? _access,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  phone: phone ?? _phone,
  idNumber: idNumber ?? _idNumber,
  idFrontImage: idFrontImage ?? _idFrontImage,
  idBackImage: idBackImage ?? _idBackImage,
  drivingLicenseImage: drivingLicenseImage ?? _drivingLicenseImage,
);
  String? get refresh => _refresh;
  String? get access => _access;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  dynamic get idNumber => _idNumber;
  dynamic get idFrontImage => _idFrontImage;
  dynamic get idBackImage => _idBackImage;
  dynamic get drivingLicenseImage => _drivingLicenseImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = _refresh;
    map['access'] = _access;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['id_number'] = _idNumber;
    map['id_front_image'] = _idFrontImage;
    map['id_back_image'] = _idBackImage;
    map['driving_license_image'] = _drivingLicenseImage;
    return map;
  }

}