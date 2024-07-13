import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String baseUrl =
      'https://api.themoviedb.org/3/'; // Replace with your API base URL
  static const String key =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3Y2UyYmJhNjBmMTA4NzcwNDc2NjEzMDFmZGQzZTIyMiIsIm5iZiI6MTcyMDc5NjMxOC4yOTAzMjgsInN1YiI6IjY2OGViMjA1NTk2NmIzOWJmYmI2YTBjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WKGPH7oIYrxzapqQiYqARFrzIkpsCexUjFkDOEnX2vQ";

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'), headers: {
      "Authorization": "Bearer $key",
      "accept": "application/json",
    });
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data,
      {String? contentType}) async {
    print('$baseUrl$endpoint');
    print(data);
    print(contentType);
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': contentType ?? 'application/json'},
      body: contentType != null
          ? Uri.encodeQueryComponent(data.toString())
          : json.encode(data),
    );
    print(response.statusCode);
    print(response.body);
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
