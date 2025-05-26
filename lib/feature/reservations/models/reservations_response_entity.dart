import 'dart:convert';

List<ReservationsResponseEntity> reservationsResponseEntityListFromJson(String str) =>
    List<ReservationsResponseEntity>.from(json.decode(str).map((x) => ReservationsResponseEntity.fromJson(x)));

String reservationsResponseEntityListToJson(List<ReservationsResponseEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ReservationsResponseEntity reservationsResponseEntityFromJson(String str) => ReservationsResponseEntity.fromJson(json.decode(str));

String reservationsResponseEntityToJson(ReservationsResponseEntity data) => json.encode(data.toJson());

class ReservationsResponseEntity {
  ReservationsResponseEntity({
    this.idReservation,
    this.car,
    this.startDate,
    this.endDate,
    this.typeReservation,
    this.statusReservation,
    this.timeReservation,
    this.remainingTime,
  });

  num? idReservation;
  num? car;
  String? startDate;
  String? endDate;
  String? typeReservation;
  String? statusReservation;
  String? timeReservation;
  String? remainingTime;

  factory ReservationsResponseEntity.fromJson(Map<String, dynamic> json) => ReservationsResponseEntity(
    idReservation: json['id_reservation'],
    car: json['car']['id_car'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    typeReservation: json['type_reservation'],
    statusReservation: json['status_reservation'],
    timeReservation: json['time_reservation'],
    // remainingTime: json['remaining_time'],
  );

  Map<String, dynamic> toJson() => {
    'id_reservation': idReservation,
    'car': car,
    'start_date': startDate,
    'end_date': endDate,
    'type_reservation': typeReservation,
    'status_reservation': statusReservation,
    'time_reservation': timeReservation,
    'remaining_time': remainingTime,
  };

  ReservationsResponseEntity copyWith({
    num? idReservation,
    num? car,
    String? startDate,
    String? endDate,
    String? typeReservation,
    String? statusReservation,
    String? timeReservation,
    String? remainingTime,
  }) =>
      ReservationsResponseEntity(
        idReservation: idReservation ?? this.idReservation,
        car: car ?? this.car,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        typeReservation: typeReservation ?? this.typeReservation,
        statusReservation: statusReservation ?? this.statusReservation,
        timeReservation: timeReservation ?? this.timeReservation,
        remainingTime: remainingTime ?? this.remainingTime,
      );
}
