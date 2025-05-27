
import 'dart:convert';
import 'dart:io';
import 'package:car_rental_app/core/storage/shared/shared_pref.dart';
import 'package:path/path.dart';
import 'package:http/http.dart'as http;
 class HttpMethods{


  postMethod(String url,var body)async{
    print(body);
    print('7777777777777777777777777777');
  http.Response response = await  http.post(
      Uri.parse(url),
      body: body,

    headers: AppSharedPreferences.getToken().isNotEmpty ?{
      "Accept": "application/json",
      "Authorization": "Bearer ${AppSharedPreferences.getToken()}",
    }:{},
  );
  print('0posssssssssssssssssssssssssssssssssssssssssss')
;  print(url)
  ;
  print(AppSharedPreferences.getToken());
  print(body);
  print(response.body);
  print(response.statusCode);
  return response;
  }
  putMethod(String url,String id)async{
    print('$url/$id/');
    http.Response response = await  http.put(
      Uri.parse('$url/$id/'),
      // body: body,

      headers: AppSharedPreferences.getToken().isNotEmpty ?{
        "Accept": "application/json",
        "Authorization": "Bearer ${AppSharedPreferences.getToken()}",
      }:{},
    );
    print(url)
    ;
    print(AppSharedPreferences.getToken());
    print(response.body);
    print(utf8.decode(response.bodyBytes));
    return response;
  }
  getMethod(String url,Map<String, dynamic>? params)async{

    if (params != null && params.isNotEmpty) {
      Uri uri = Uri.parse(url).replace(queryParameters: params);
      url = uri.toString();
    }
    print(url)
;
    print(AppSharedPreferences.getToken());
    print('-----------------------------------');
    http.Response response = await http.get(
      Uri.parse(url),
      headers: AppSharedPreferences.getToken().isNotEmpty ?{
        "Accept": "application/json",
        "Authorization": "Bearer ${AppSharedPreferences.getToken()}",
      }:{},

    );
    print(AppSharedPreferences.getToken());
    print(response.body);
    print(response.statusCode);
    return response;
  }

  postWithMultiFile(String url, Map data, List<File> files,List<String>names) async {
    var multipartrequest = await http.MultipartRequest('POST', Uri.parse(url));
   print(data);
   print('dddddddddd555555555ddddddddddddddddddddddd');
    for (int i = 0; i < files.length; i++) {
      var length = await files[i].length();
      var stream = await http.ByteStream(files[i].openRead());
      var multipartfile = await http.MultipartFile(names[i], stream, length,
          filename: basename(files[i].path));
      multipartrequest.files.add(multipartfile);
    }
    if(AppSharedPreferences.getToken().isNotEmpty){
      multipartrequest.headers['Authorization'] = 'Bearer ${AppSharedPreferences.getToken()}';

    }
    print(url)
    ;
    data.forEach((key, value) {
      multipartrequest.fields[key] = value;
    });
    http.StreamedResponse sresponce = await multipartrequest.send();
    http.Response response = await http.Response.fromStream(sresponce);
    print(utf8.decode(response.bodyBytes));
    return jsonDecode(response.body);
  }



 }