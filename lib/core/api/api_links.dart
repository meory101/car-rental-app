
String _baseUrl = 'http://192.168.156.164:8000/';
// String imageUrl = 'http://192.168.55.164:8000/storage/';

class ApiGetUrl {

  static  String cars = '${_baseUrl}car/list/';
  static  String customers = '${_baseUrl}account/customer/user-list/';
  static  String myReservations = '${_baseUrl}car/my-temporary-reservations/';
  static  String search = '${_baseUrl}car/serche-customer/';
  static  String listOffices = '${_baseUrl}car/office/list-create/';

}

class ApiPostUrl {
  static  String login = '${_baseUrl}account/login/';
  static  String addCar = '${_baseUrl}car/customer  /list-create/';
  static  String register = '${_baseUrl}account/register/';
  static  String reserve = '${_baseUrl}car/reserve/';
  static  String cancel = '${_baseUrl}car/reserve/cancel';

}

class ApiDeleteUrl {}

class ApiPutUrl {}
