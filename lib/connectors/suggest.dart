import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:dostavka/connectors/apis.dart';
import 'package:dostavka/models/data.dart';

import 'package:http/io_client.dart' as http;
import 'dart:io';

// flutter packages pub run build_runner watch

// This is necessary for the generator to work.
part "suggest.chopper.dart";

@ChopperApi(baseUrl: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address")
abstract class Suggest extends ChopperService {

@Post()
Future<Response> getAddressSuggest(
    @Header('Authorization') String token,
    @Field('query') String city,
    @Field('from_bound') Map<String, String> from,
    @Field('to_bound') Map<String, String> to,
    // @Body() String body,
    );

static Suggest create() {

// final ioc = new HttpClient();
// ioc.findProxy = (url) => 'PROXY 192.168.0.102:9090';
// ioc.badCertificateCallback = (X509Certificate cert, String host, int port)
// => true;

final client = ChopperClient(
// baseUrl: "195.2.70.91",
services: [
_$Suggest(),
],
converter: JsonConverter(),
interceptors: [
HttpLoggingInterceptor(),
  MyRequestInterceptor(),
]);
return _$Suggest(client);
}
}

class MyRequestInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    print(request);
    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    return response;
  }
}

// {
// "query": "г.",
// "from_bound": { "value": "city" },
// "to_bound": { "value": "city" }
// }