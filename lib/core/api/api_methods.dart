
import 'dart:convert';
import 'dart:io';
import 'package:car_rental_app/core/storage/shared/shared_pref.dart';
import 'package:path/path.dart';

import 'package:http/http.dart'as http;
 class HttpMethods{


  postMethod(String url,var body)async{
  http.Response response = await  http.post(
      Uri.parse(url),
      body: body,

    headers: AppSharedPreferences.getToken().isNotEmpty ?{
      "Accept": "application/json",
      "Authorization": "Bearer ${AppSharedPreferences.getToken()}",
    }:{},
  );
  print(AppSharedPreferences.getToken());
  print(body);
  print(response.body);
  print(response.statusCode);
  return response;
  }

  getMethod(String url,)async{

    http.Response response = await  http.get(
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
    for (int i = 0; i < files.length; i++) {
      var length = await files[i].length();
      var stream = await http.ByteStream(files[i].openRead());
      var multipartfile = await http.MultipartFile(names[i], stream, length,
          filename: basename(files[i].path));
      multipartrequest.files.add(multipartfile);
    }
    data.forEach((key, value) {
      multipartrequest.fields[key] = value;
    });
    http.StreamedResponse sresponce = await multipartrequest.send();
    http.Response response = await http.Response.fromStream(sresponce);
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }



 }