import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ErrorHandlingExample extends StatefulWidget {
  const ErrorHandlingExample({super.key});

  @override
  State<ErrorHandlingExample> createState() => _ErrorHandlingExampleState();
}

class _ErrorHandlingExampleState extends State<ErrorHandlingExample> {
  final httpClient = EwaHttpClient();
  String _lastErrorMessage = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the HTTP client
    httpClient.init(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
  }

  /// Example of making an API call with proper error handling
  Future<void> _makeApiCall() async {
    setState(() {
      _isLoading = true;
      _lastErrorMessage = '';
    });

    try {
      // This will likely succeed
      final response = await httpClient.get('/posts/1');
      // ignore: avoid_print
      print('Success: ${response.data}');

      if (mounted) {
        setState(() {
          _isLoading = false;
          _lastErrorMessage = 'Successfully fetched data!';
        });
      }
    } on DioException catch (e) {
      // Convert DioException to our structured error
      final ewaException = e.toEwaResponseException();
      ewaException.logError(); // Log for debugging

      if (mounted) {
        setState(() {
          _isLoading = false;
          _lastErrorMessage = ewaException.message;
        });
      }
    } catch (e) {
      // Handle any other unexpected errors
      EwaLogger.error('Unexpected error occurred: $e');

      if (mounted) {
        setState(() {
          _isLoading = false;
          _lastErrorMessage = 'Terjadi kesalahan tidak terduga';
        });
      }
    }
  }

  /// Example of making an API call that will fail (404)
  Future<void> _makeNotFoundCall() async {
    setState(() {
      _isLoading = true;
      _lastErrorMessage = '';
    });

    try {
      // This will return a 404 error
      final response = await httpClient.get('/nonexistent-endpoint');
      // ignore: avoid_print
      print('Success: ${response.data}');
    } on DioException catch (e) {
      // Convert DioException to our structured error
      final ewaException = e.toEwaResponseException();
      ewaException.logError(); // Log for debugging

      if (mounted) {
        setState(() {
          _isLoading = false;
          _lastErrorMessage = ewaException.message;
        });
      }
    } catch (e) {
      // Handle any other unexpected errors
      EwaLogger.error('Unexpected error occurred: $e');

      if (mounted) {
        setState(() {
          _isLoading = false;
          _lastErrorMessage = 'Terjadi kesalahan tidak terduga';
        });
      }
    }
  }

  /// Example of simulating a network error
  Future<void> _simulateNetworkError() async {
    setState(() {
      _isLoading = true;
      _lastErrorMessage = '';
    });

    try {
      // Create a new client with an invalid URL to simulate network error
      final invalidClient = EwaHttpClient();
      invalidClient.init(
        baseUrl: 'https://invalid-domain-that-does-not-exist-12345.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      );

      await invalidClient.get('/');
    } on DioException catch (e) {
      // Convert DioException to our structured error
      final ewaException = e.toEwaResponseException();
      ewaException.logError(); // Log for debugging

      if (mounted) {
        setState(() {
          _isLoading = false;
          _lastErrorMessage = ewaException.message;
        });
      }
    } catch (e) {
      // Handle any other unexpected errors
      EwaLogger.error('Unexpected error occurred: $e');

      if (mounted) {
        setState(() {
          _isLoading = false;
          _lastErrorMessage = 'Terjadi kesalahan tidak terduga';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Handling Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLoading)
              Center(
                // Fixed: Removed const since EwaLoading.bouncingDots() is not a const constructor
                child: EwaLoading.bouncingDots(),
              )
            else
              const SizedBox.shrink(),
            const SizedBox(height: 16),
            Text(
              _lastErrorMessage.isEmpty
                  ? 'Tekan tombol di bawah untuk menguji penanganan error'
                  : _lastErrorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _lastErrorMessage.contains('Success')
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            EwaButton.primary(
              label: 'Test Successful API Call',
              onPressed: _makeApiCall,
            ),
            const SizedBox(height: 16),
            EwaButton.danger(
              label: 'Test 404 Error',
              onPressed: _makeNotFoundCall,
            ),
            const SizedBox(height: 16),
            EwaButton.secondary(
              label: 'Test Network Error',
              onPressed: _simulateNetworkError,
            ),
            const SizedBox(height: 32),
            const Text(
              'Contoh Penggunaan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('''
try {
  final response = await httpClient.get('/posts/1');
  // Handle success
} on DioException catch (e) {
  final ewaException = e.toEwaResponseException();
  ewaException.logError();
  // Show user-friendly error message: ewaException.message
}''', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
