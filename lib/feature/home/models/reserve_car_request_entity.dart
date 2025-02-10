import 'dart:convert';
/// car : 1
/// start_date : "2025-02-10T10:00:00Z"
/// type_reservation : 1

ReserveCarRequestEntity reserveCarRequestEntityFromJson(String str) => ReserveCarRequestEntity.fromJson(json.decode(str));
String reserveCarRequestEntityToJson(ReserveCarRequestEntity data) => json.encode(data.toJson());
class ReserveCarRequestEntity {
  ReserveCarRequestEntity({
    String? car, 
      String? startDate,
    String? typeReservation,}){
    _car = car;
    _startDate = startDate;
    _typeReservation = typeReservation;
}

  ReserveCarRequestEntity.fromJson(dynamic json) {
    _car = json['car'];
    _startDate = json['start_date'];
    _typeReservation = json['type_reservation'];
  }

  set car(String? value) {
    _car = value;
  }

  String? _car;
  String? _startDate;
  String? _typeReservation;
ReserveCarRequestEntity copyWith({  String? car,
  String? startDate,
  String? typeReservation,
}) => ReserveCarRequestEntity(  car: car ?? _car,
  startDate: startDate ?? _startDate,
  typeReservation: typeReservation ?? _typeReservation,
);
  String? get car => _car;
  String? get startDate => _startDate;
  String? get typeReservation => _typeReservation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['car'] = _car;
    map['start_date'] = _startDate;
    map['type_reservation'] = _typeReservation;
    return map;
  }

  set startDate(String? value) {
    _startDate = value;
  }

  set typeReservation(String? value) {
    _typeReservation = value;
  }
}