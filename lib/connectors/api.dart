import "dart:async";
import 'package:chopper/chopper.dart';
import 'package:dostavka/connectors/apis.dart';
import 'package:dostavka/models/data.dart';

import 'package:http/io_client.dart' as http;
import 'dart:io';

// flutter packages pub run build_runner watch

// This is necessary for the generator to work.
part "api.chopper.dart";

@ChopperApi(baseUrl: "https://testarea.dostavka.info/api/v2/mobile")
abstract class Api extends ChopperService {
  // AUTHENTICATION//
  @Post(path: Apis.login)
  Future<Response> Login(@Body() Map<String, dynamic> body);

  @Post(path: Apis.login)
  Future<Response> SendSMS(
      @Body() Map<String, dynamic> body);

  @Post(path: Apis.logout)
  Future<Response> Logout(
      @Header('Cookie') String sessionid,
      @Body() Map<String, dynamic> body,
      );

  @Get(path: Apis.suggests)
  Future<Response> getSuggestions();
  // USER INFO
  @Get(path: Apis.settings)
  Future<Response> getUser(
      @Header('Cookie') String sessionid, @Query("username") String username);

  @Patch(path: Apis.settings)
  Future<Response> setUser(
      @Header('Cookie') String sessionid, @Header('X-CSRFToken') String csrf, @QueryMap() Map<String, dynamic> data);

  @Get(path: Apis.user)
  Future<Response> getFIO(
      @Header('Cookie') String sessionid, @Query("username") String username);

  @Patch(path: Apis.user)
  Future<Response> setFIO(
      @Header('Cookie') String sessionid, @Header('X-CSRFToken') String csrf, @Body() Map<String, dynamic> data);

  @Get(path: Apis.passport)
  Future<Response> getPassport(
      @Header('Cookie') String sessionid, @Query("username") String username);

  @Patch(path: Apis.passport)
  Future<Response> setPassport(
      @Header('Cookie') String sessionid, @Header('X-CSRFToken') String csrf, @Body() Map<String, dynamic> data);

  @Get(path: Apis.address)
  Future<Response> getAddress(
      @Header('Cookie') String sessionid,
      @Query("username") String username);

  @Patch(path: Apis.address)
  Future<Response> setAddress(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> data);

  @Post(path: Apis.address)
  Future<Response> createAddress(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> data);

  @Patch(path: Apis.address)
  Future<Response> changeAddress(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> data);

  @Get(path: Apis.security)
  Future<Response> getSecurityKey(
      @Header('Cookie') String sessionid,
      @Body() Map<String, dynamic> body,
      );

// ///////////////////////////
  @Patch(path: Apis.security)
  Future<Response> patchSecurityKey(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> data);

//////////// uuid ?
  @Get(path: Apis.offices)
  Future<Response> getOffices(
      // @Header('Cookies') String sessionid,
      @Body() Map<String, dynamic> body);

  @Get(path: Apis.offices)
  Future<Response> getAllOffices();

  // ALL DRAFTS
  @Get(path: Apis.drafts)
  Future<Response> getDrafts(
      @Header('Cookie') String sessionid,
      @Query('way') String way,);
  // @Body() Map<String, dynamic> body);

  // DRAFT CONNECTORS
  @Get(path: Apis.draft)
  Future<Response> getDraft(@Header('Cookie') String sessionid,
      @Query("number") String number);

  @Post(path: Apis.draft)
  Future<Response> createDraft(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> body);

  @Patch(path: Apis.draft)
  Future<Response> changeDraft(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> body);

  @Delete(path: Apis.draft)
  Future<Response> deleteDraft(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> body);

  // CARGO CONNECTORS

  @Get(path: Apis.cargo)
  Future<Response> getCargo(@Header('Cookie') String sessionid,
      @QueryMap() Map<String, dynamic> body);

  @Post(path: Apis.cargo)
  Future<Response> createCargo(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> body);

  @Patch(path: Apis.cargo)
  Future<Response> changeCargo(@Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> body);

  @Delete(path: Apis.cargo)
  Future<Response> deleteCargo(
      @Header('Cookie') String sessionid,
      @Body() Map<String, dynamic> body
      );

  // ALL ORDERS

  //outbox inbox condition ?
  @Get(path: Apis.orders)
  Future<Response> getOrders(
      @Header('Cookie') String sessionid,
      @Query('way') String way,
      @Query('condition') String condition,);

  // ORDER CONNECTORS
  @Get(path: Apis.order)
  Future<Response> getOrder(
      @Header('Cookie') String sessionid,
      @Body() Map<String, dynamic> body
      );

  // CREATE PUSH NOTIFICATION TOKEN
  @Post(path: Apis.push)
  Future<Response> postPushToken(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> body,
      );

  // PROMOCODE
  @Post(path: Apis.promo)
  Future<Response> usePromocode(
      @Header('Cookie') String sessionid,
      @Header('X-CSRFToken') String csrf,
      @Body() Map<String, dynamic> body,
      );

  static Api create() {

    // final ioc = new HttpClient();
    // ioc.findProxy = (url) => 'PROXY 192.168.0.102:9090';
    // ioc.badCertificateCallback = (X509Certificate cert, String host, int port)
    // => true;

    final client = ChopperClient(
      // baseUrl: "195.2.70.91",
        services: [
          _$Api(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
        ]);
    return _$Api(client);
  }
}

// @RestApi(baseUrl: "195.2.70.91/api/v2/mobile/ ")
// abstract class ApiClient {
//   factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

//   @GET(Apis.offices)
//   Future<ResponseData> getOffices();
// }
