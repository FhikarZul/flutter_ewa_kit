import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';

class HttpExampleScreen extends StatefulWidget {
  const HttpExampleScreen({super.key});

  @override
  State<HttpExampleScreen> createState() => _HttpExampleScreenState();
}

class _HttpExampleScreenState extends State<HttpExampleScreen> {
  final _httpClient = EwaHttpClient();
  String _response = 'No response yet';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initHttpClient();
  }

  Future<void> _initHttpClient() async {
    await _httpClient.init(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      defaultHeaders: {'Content-Type': 'application/json'},
      enableCaching: true,
    );
    _httpClient.refreshTokenCallback = _refreshTokens;
    _httpClient.onLogout = _handleLogout;
  }

  Future<bool> _refreshTokens() async {
    await Future.delayed(const Duration(seconds: 1));
    _httpClient.setTokens('new_access_token', 'new_refresh_token');
    return true;
  }

  void _handleLogout() {
    _httpClient.clearTokens();
    setState(() => _response = 'Logged out due to token refresh failure');
  }

  Future<void> _makeGetRequest() async {
    setState(() {
      _isLoading = true;
      _response = 'Loading...';
    });
    try {
      final response = await _httpClient.get('/posts/1');
      setState(() {
        _response = 'GET Response: ${response.data}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _response = 'GET Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP Client Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EwaButton.primary(
              label: 'Make GET Request',
              onPressed: _isLoading ? null : _makeGetRequest,
            ),
            const SizedBox(height: 16),
            if (_isLoading) EwaLoading.bouncingDots(),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(child: Text(_response)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
