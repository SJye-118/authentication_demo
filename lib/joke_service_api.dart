import 'dart:convert';
import 'package:http/http.dart' as http;

class JokeService {
  static const String _apiUrl = 'https://v2.jokeapi.dev/joke/Programming';

  Future<String> fetchJoke() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['type'] == 'single') {
        return data['joke'];
      } else if (data['type'] == 'twopart') {
        return '${data['setup']} - ${data['delivery']}';
      } else {
        return 'No joke available';
      }
    } else {
      throw Exception('Failed to load joke');
    }
  }
}
