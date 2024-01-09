import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> makePostRequest(
    String url, Map<String, String> body) async {
  return http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
}

Future<Map<String, dynamic>> callApi() async {
  String url = 'https://api.thenotary.app/lead/getLeads';
  Map<String, String> body = {
    'notaryId': '643074200605c500112e0902',
  };

  try {
    http.Response response = await makePostRequest(url, body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('Error: $e');
    return {};
  }
}
