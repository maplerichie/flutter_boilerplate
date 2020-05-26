import 'package:dio/dio.dart';

class HttpService {
  static const endpoint = 'https://enad54jjotq3u.x.pipedream.net';
  Dio req = new Dio();

  HttpService() {
    req.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          req.interceptors.requestLock.lock();
          var token = 'interceptor';
          options.headers = {
            'Authorization': 'Bearer: $token',
          };
          req.interceptors.requestLock.unlock();
          return options;
        },
      ),
    );
  }

  Future<dynamic> get(String path, dynamic data) async {
    try {
      Response res = await req.get(
        '$endpoint/$path' + (data != null ? '/$data' : ''),
      );
      // response = await req.get("/test", queryParameters: data);
      return res.data;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> post(String path, dynamic data) async {
    try {
      Response res = await req.post(
        '$endpoint/$path',
        data: data,
      );

      return res.data;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> download(String filePath, String savePath) async {
    try {
      Response res = await req.download(
        '$endpoint/$filePath',
        savePath,
        onReceiveProgress: (int sent, int total) {
          print("$sent $total");
        },
      );

      return res.data;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> upload(String path, dynamic binaryData) async {
    try {
      Response res = await req.post(
        '$endpoint/$path',
        data: Stream.fromIterable(binaryData.map((e) => [e])),
        options: Options(
          headers: {
            Headers.contentLengthHeader: binaryData.length,
          },
        ),
        onSendProgress: (int sent, int total) {
          print("$sent $total");
        },
      );

      return res.data;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

// GET /tickets - Retrieves a list of tickets
// GET /tickets/12 - Retrieves a specific ticket
// POST /tickets - Creates a new ticket
// PUT /tickets/12 - Updates ticket #12
// PATCH /tickets/12 - Partially updates ticket #12
// DELETE /tickets/12 - Deletes ticket #12
