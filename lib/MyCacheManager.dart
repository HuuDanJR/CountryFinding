// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';

// class MyCacheManager extends BaseCacheManager {
//   static const key = "my_cache";

//   static MyCacheManager _instance;

//   /// The DefaultCacheManager that can be easily used directly. The code of
//   /// this implementation can be used as inspiration for more complex cache
//   /// managers.
//   factory MyCacheManager() {
//     if (_instance == null) {
//       _instance = new MyCacheManager._();
//     }
//     return _instance;
//   }

//   MyCacheManager._()
//       : super(
//           key,
//           fileFetcher: _myHttpGetter,
//         );

//   Future<String> getFilePath() async {
//     var directory = await getTemporaryDirectory();
//     return p.join(directory.path, key);
//   }

//   static Future<FileFetcherResponse> _myHttpGetter(String url,
//       {Map<String, String> headers}) async {
//     var token = await UserInfoManager.getToken();
//     if (token != null) {
//       headers["Authorization"] = token;
//     }
//     var httpResponse = await http.get(url, headers: headers);
//     return new MyHttpFileFetcherResponse(httpResponse);
//   }
// }

// class MyHttpFileFetcherResponse extends HttpFileFetcherResponse {
//   http.Response _mResponse;

//   MyHttpFileFetcherResponse(this._mResponse) : super(_mResponse);

//   @override
//   get statusCode {
//    // see here, rewrite error response
//     try {
//       return _mResponse.statusCode == 200 &&
//               _mResponse.headers['content-type'].toString().contains("json")
//           ? 404
//           : _mResponse.statusCode;
//     } catch (e) {
//       print(e);
//       return super.statusCode;
//     }
//   }
// }