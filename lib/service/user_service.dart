import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UserService {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsers() async {
    try {
      log('Fetching users from: $_baseUrl');
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = json.decode(response.body);
          return data.map((json) => User.fromJson(json)).toList();
        } catch (e) {
          log('Error parsing response: $e');
          throw Exception('Failed to parse user data. Please try again later.');
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw Exception(
          'Client error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      } else if (response.statusCode >= 500) {
        throw Exception(
          'Server error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      } else {
        throw Exception('Unexpected error occurred: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      log('Format exception: $e');
      throw Exception('Invalid data format received from server');
    } on http.ClientException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception(
        'Failed to load users. Please check your connection and try again.',
      );
    }
  }
}
