import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://autism-screening-api.onrender.com";

  static Future<double> submitAnswers(List<int> answers) async {
    final response = await http.post(
      Uri.parse("$baseUrl/screen"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"answers": answers}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["autism_likelihood"] ?? 0.0;
    } else {
      throw Exception("Failed to connect to backend");
    }
  }
}