import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HttpExampleScreen extends StatefulWidget {
  const HttpExampleScreen({super.key});

  @override
  State<HttpExampleScreen> createState() => _HttpExampleScreenState();
}

class _HttpExampleScreenState extends State<HttpExampleScreen> {
  final _httpClient = EwaHttpClient();
  String _response = 'No response yet';
  bool _isLoading = false;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize the HTTP client with caching enabled
    _initHttpClient();
  }

  /// Initialize the HTTP client asynchronously
  Future<void> _initHttpClient() async {
    _httpClient.init(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      defaultHeaders: {'Content-Type': 'application/json'},
      enableCaching: true, // Enable caching for offline support
    );

    // Set up token refresh callback
    _httpClient.refreshTokenCallback = _refreshTokens;

    // Set up logout callback
    _httpClient.onLogout = _handleLogout;
  }

  /// Simulate token refresh
  Future<bool> _refreshTokens() async {
    // In a real app, you would make an API call to refresh the token
    await Future.delayed(const Duration(seconds: 1));
    _httpClient.setTokens('new_access_token', 'new_refresh_token');
    return true;
  }

  /// Handle logout
  void _handleLogout() {
    _httpClient.clearTokens();
    setState(() {
      _response = 'Logged out due to token refresh failure';
    });
  }

  /// Toggle caching
  void _toggleCaching() {
    if (_httpClient.isCachingEnabled) {
      _httpClient.disableCaching();
      setState(() {
        _response = 'Caching disabled';
      });
    } else {
      _httpClient.enableCaching();
      setState(() {
        _response = 'Caching enabled';
      });
    }
  }

  /// Clear cache
  Future<void> _clearCache() async {
    await _httpClient.clearCache();
    setState(() {
      _response = 'Cache cleared';
    });
  }

  /// Download a file
  Future<void> _downloadFile() async {
    setState(() {
      _isLoading = true;
      _response = 'Starting download...';
      _downloadProgress = 0.0;
    });

    try {
      // Get the documents directory
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/sample_image.jpg';

      // Download a sample image
      final filePath = await _httpClient.downloadFile(
        'https://picsum.photos/500/500',
        savePath,
        onProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
              _response =
                  'Downloading: ${(received / total * 100).toStringAsFixed(1)}%';
            });
          }
        },
      );

      setState(() {
        _response = 'File downloaded to: $filePath';
        _isLoading = false;
        _downloadProgress = 1.0;
      });
    } catch (e) {
      setState(() {
        _response = 'Download Error: $e';
        _isLoading = false;
        _downloadProgress = 0.0;
      });
    }
  }

  /// Download a file with resume capability
  Future<void> _downloadFileWithResume() async {
    setState(() {
      _isLoading = true;
      _response = 'Starting resumable download...';
      _downloadProgress = 0.0;
    });

    try {
      // Get the documents directory
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/sample_resume_image.jpg';

      // Download a sample image with resume capability
      final filePath = await _httpClient.downloadFileWithResume(
        'https://picsum.photos/800/800',
        savePath,
        onProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
              _response =
                  'Downloading: ${(received / total * 100).toStringAsFixed(1)}%';
            });
          }
        },
      );

      setState(() {
        _response = 'File downloaded to: $filePath';
        _isLoading = false;
        _downloadProgress = 1.0;
      });
    } catch (e) {
      setState(() {
        _response = 'Resumable Download Error: $e';
        _isLoading = false;
        _downloadProgress = 0.0;
      });
    }
  }

  /// Make a GET request
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

  /// Make a POST request
  Future<void> _makePostRequest() async {
    setState(() {
      _isLoading = true;
      _response = 'Loading...';
    });

    try {
      final response = await _httpClient.post(
        '/posts',
        data: {
          'title': 'Test Post',
          'body': 'This is a test post',
          'userId': 1,
        },
      );
      setState(() {
        _response = 'POST Response: ${response.data}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _response = 'POST Error: $e';
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
            ElevatedButton(
              onPressed: _isLoading ? null : _makeGetRequest,
              child: const Text('Make GET Request'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _makePostRequest,
              child: const Text('Make POST Request'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _downloadFile,
              child: const Text('Download File'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _downloadFileWithResume,
              child: const Text('Download File with Resume'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleCaching,
              child: Text(
                _httpClient.isCachingEnabled
                    ? 'Disable Caching'
                    : 'Enable Caching',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _clearCache,
              child: const Text('Clear Cache'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      _httpClient.setTokens('test_token', 'test_refresh_token');
                      setState(() {
                        _response = 'Tokens set';
                      });
                    },
              child: const Text('Set Tokens'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      _httpClient.clearTokens();
                      setState(() {
                        _response = 'Tokens cleared';
                      });
                    },
              child: const Text('Clear Tokens'),
            ),
            const SizedBox(height: 16),
            if (_isLoading && _downloadProgress > 0)
              LinearProgressIndicator(value: _downloadProgress),
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
