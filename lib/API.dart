import 'package:dio/dio.dart';

final dio = Dio();

var baseUrl = 'http://localhost:8000/api/';
Future<Response> getReq(String url) async {
  Response response;
  response = await dio.get(baseUrl + url);

  return response;
}

Future<Response> getWithParams(String url, Map<String, dynamic> params) async {
  Response response;

  response = await dio.get(
    baseUrl + url,
    queryParameters: params,
  );

  return response;
}

Future<Response> postData(url, body) async {
  Response response;
  print(baseUrl);
  response = await dio.post(baseUrl + url, data: body);

  return response;
}

Future<Response> delData(url) async {
  Response response;
  print(baseUrl);
  response = await dio.delete(baseUrl + url);

  return response;
}

Future<Response> editData(url, body) async {
  Response response;
  print(baseUrl);
  response = await dio.put(baseUrl + url, data: body);

  return response;
}
