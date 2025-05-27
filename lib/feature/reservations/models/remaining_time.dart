import 'dart:convert';
/// mint : 118
/// second : 3

RemainingTime remainingTimeFromJson(String str) => RemainingTime.fromJson(json.decode(str));
String remainingTimeToJson(RemainingTime data) => json.encode(data.toJson());
class RemainingTime {
  RemainingTime({
      num? mint, 
      num? second,}){
    _mint = mint;
    _second = second;
}

  RemainingTime.fromJson(dynamic json) {
    _mint = json['mint'];
    _second = json['second'];
  }
  num? _mint;
  num? _second;
RemainingTime copyWith({  num? mint,
  num? second,
}) => RemainingTime(  mint: mint ?? _mint,
  second: second ?? _second,
);
  num? get mint => _mint;
  num? get second => _second;


  set  mint(num?value){
    _mint = value;
  }
  set  second(num?value){
    _second = value;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mint'] = _mint;
    map['second'] = _second;
    return map;
  }

}