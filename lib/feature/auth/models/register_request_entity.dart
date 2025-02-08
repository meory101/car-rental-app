import 'dart:convert';
/// first_name : "fof"
/// last_name : "fof"
/// email : "fof@gmail.com"
/// username : "fof"
/// password : "1234"
/// account_type : "customer"
/// phone : "0936793000"

RegisterRequestEntity registerRequestEntityFromJson(String str) => RegisterRequestEntity.fromJson(json.decode(str));
String registerRequestEntityToJson(RegisterRequestEntity data) => json.encode(data.toJson());
class RegisterRequestEntity {
  RegisterRequestEntity({
      String? firstName, 
      String? lastName, 
      String? email, 
      String? username, 
      String? password, 
      String? accountType, 
      String? phone,}){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _username = username;
    _password = password;
    _accountType = accountType;
    _phone = phone;
}

  RegisterRequestEntity.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _username = json['username'];
    _password = json['password'];
    _accountType = json['account_type'];
    _phone = json['phone'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _username;
  String? _password;
  String? _accountType;
  String? _phone;
RegisterRequestEntity copyWith({  String? firstName,
  String? lastName,
  String? email,
  String? username,
  String? password,
  String? accountType,
  String? phone,
}) => RegisterRequestEntity(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  username: username ?? _username,
  password: password ?? _password,
  accountType: accountType ?? _accountType,
  phone: phone ?? _phone,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get username => _username;
  String? get password => _password;
  String? get accountType => _accountType;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['username'] = _username;
    map['password'] = _password;
    map['account_type'] = "customer";
    map['phone'] = _phone;
    print(map);
    return map;
  }

  set phone(String? value) {
    _phone = value;
  }

  set accountType(String? value) {
    _accountType = value;
  }

  set password(String? value) {
    _password = value;
  }

  set username(String? value) {
    _username = value;
  }

  set email(String? value) {
    _email = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set firstName(String? value) {
    _firstName = value;
  }
}