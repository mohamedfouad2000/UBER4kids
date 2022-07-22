import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class locationserves {
  final String key = 'AIzaSyC-2mhBCGZJKznNXb3OyAsjJesjjU8i6sY';
  Future<String> getplaceid(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?&input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeid = json['candidates'][0]['place_id'] as String;
    print(placeid);
    return placeid;
  }

  Future<Map<String, dynamic>> getplace(String input) async {
    final placeId =await getplaceid(input);
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?&place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results=json['result'] as Map<String, dynamic>;
    print(results);
    return results;
  }
}
