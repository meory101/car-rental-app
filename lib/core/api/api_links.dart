
String _baseUrl = 'http://192.168.146.164:8000/';
// String imageUrl = 'http://192.168.55.164:8000/storage/';

class ApiGetUrl {

  static  String cars = '${_baseUrl}car/list/';

}

class ApiPostUrl {
  static  String login = '${_baseUrl}account/login/';
  static  String register = '${_baseUrl}account/register/';
  static  String reserve = '${_baseUrl}car/reserve/';

}

class ApiDeleteUrl {}

class ApiPutUrl {}
