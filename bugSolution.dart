```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // Use jsonData
    } else {
      throw HttpException('Failed to load data: ${response.statusCode}', response.body);
    }
  } on SocketException catch (e) {
    print('SocketException: Could not connect to the server: $e');
    rethrow; // Re-throw to allow higher level error handling
  } on FormatException catch (e) {
    print('FormatException: Invalid JSON response: $e');
    rethrow; // Re-throw to allow higher level error handling
  } on HttpException catch (e) {
    print('HttpException: HTTP error: ${e.message}, response body: ${e.response}');
    rethrow; // Re-throw to allow higher level error handling
  } catch (e) {
    print('Unexpected error: $e');
    rethrow; // Re-throw to allow higher level error handling
  }
}

class HttpException implements Exception {
  final String message;
  final String? response;

  HttpException(this.message, this.response);

  @override
  String toString() => 'HttpException: $message';
}
```