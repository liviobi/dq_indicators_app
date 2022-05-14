import 'package:http/http.dart' as http;
import 'dart:convert';

const endPoint = "http://127.0.0.1:5000/";

getFiles() async {
  var response = await http.get(Uri.parse(endPoint + "file"));
  //dynamic body = json.decode(response.body);
  //return body["files"];

  final jsonData = json.decode(response.body);
  final files = <String>[];
  for (var item in jsonData["files"]) {
    files.add(item);
  }
  return files;
}

deleteFile(filename) async {
  final url = Uri.parse(endPoint + "file");
  Map<String, String> requestBody = <String, String>{
    'filename': filename,
  };
  var request = http.MultipartRequest('DELETE', url)
    ..fields.addAll(requestBody);
  final response = await request.send();

  return response.statusCode;
}
