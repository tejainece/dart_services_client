part of dart_analyser_client.http;

class Client {
  final String baseUrl;

  final http.Client _client = new http.Client();

  Client({this.baseUrl: ''});

  Future<http.Response> get(String path,
      {Map<String, String> headers, Map<String, String> queryParams}) {
    Uri uri = new Uri.http(baseUrl, path, queryParams);
    return _client.get(uri, headers: headers);
  }

  Future<http.Response> post(String path,
      {Map<String, String> headers,
      Map<String, String> queryParams,
      String body,
      Encoding encoding}) {
    Uri uri = new Uri.http(baseUrl, path, queryParams);
    return _client.post(uri, headers: headers, body: body, encoding: encoding);
  }
}
