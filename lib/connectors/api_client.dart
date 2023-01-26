// import 'package:dio/dio.dart';
// import 'package:dostavka/models/models.dart';
// import 'package:dostavka/models/data.dart';
// import 'package:dostavka/connectors/apis.dart';
// import 'package:retrofit/http.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'api_client.g.dart';
import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:dostavka/connectors/apis.dart';
import 'package:dostavka/models/data.dart';
import 'package:dostavka/models/models.dart';

// This is necessary for the generator to work.
part "api_client.chopper.dart";

//      "is_login": true,
// "sessionid": "3ghqzg7iwflrblw5uqzkkr6rf00mdvs6",
// "token": "e87598a26917c0dbd28528457177f00d4822e822"

@ChopperApi(baseUrl: "195.2.70.91/api/v2/mobile")
abstract class ApiClient extends ChopperService {
  // AUTHENTICATION
  @Post(path: Apis.login)
  Future<Response> Login(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: Apis.logout)
  Future<Response> Logout(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // USER INFO
  @Get(path: Apis.settings)
  Future<Response<User>> getUser(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: Apis.user)
  Future<Response> getFIO(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: Apis.passport)
  Future<Response> getPassport(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: Apis.address)
  Future<Response> getAddress(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: Apis.security)
  Future<Response> getSecurityKey(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: Apis.offices)
  Future<Response> getOffices(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // ALL DRAFTS
  @Get(path: Apis.drafts)
  Future<Response> getDrafts(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // DRAFT CONNECTORS
  @Get(path: Apis.draft)
  Future<Response> getDraft(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Post(path: Apis.draft)
  Future<Response> createDraft(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Patch(path: Apis.draft)
  Future<Response> changeDraft(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Delete(path: Apis.draft)
  Future<Response> deleteDraft(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // CARGO CONNECTORS

  @Get(path: Apis.cargo)
  Future<Response> getCargo(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Post(path: Apis.cargo)
  Future<Response> createCargo(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Patch(path: Apis.cargo)
  Future<Response> changeCargo(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  @Delete(path: Apis.cargo)
  Future<Response> deleteCargo(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // ALL ORDERS
  @Get(path: Apis.orders)
  Future<Response> getOrders(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // ORDER CONNECTORS
  @Get(path: Apis.order)
  Future<Response> getOrder(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // CREATE PUSH NOTIFICATION TOKEN
  @Post(path: Apis.push)
  Future<Response> postPushToken(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  // PROMOCODE
  @Post(path: Apis.promo)
  Future<Response> usePromocode(
    @Header('Cookies') String sessionid,
    @Body() Map<String, dynamic> body,
  );

  static ApiClient create() {
    final client = ChopperClient(
        baseUrl: "195.2.70.91",
        services: [
          _$ApiClient(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
        ]);
    return _$ApiClient(client);
  }
}

// @RestApi(baseUrl: "195.2.70.91/api/v2/mobile/ ")
// abstract class ApiClient {
//   factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

//   @GET(Apis.offices)
//   Future<ResponseData> getOffices();
// }
