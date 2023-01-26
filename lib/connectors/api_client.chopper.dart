// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ApiClient extends ApiClient {
  _$ApiClient([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiClient;

  @override
  Future<Response<dynamic>> Login(Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> Logout(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/logout';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<User>> getUser(String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/settings';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<User, User>($request);
  }

  @override
  Future<Response<dynamic>> getFIO(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/settings/user';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPassport(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/settings/passport';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAddress(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/settings/address';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSecurityKey(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/settings/security';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOffices(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/offices';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDrafts(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/drafts';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDraft(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/draft';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createDraft(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/draft';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeDraft(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/draft';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteDraft(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/draft';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('DELETE', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCargo(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/cargo';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createCargo(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/cargo';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeCargo(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/cargo';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteCargo(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/cargo';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('DELETE', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOrders(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/orders';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOrder(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/order';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPushToken(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/push_token';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> usePromocode(
      String sessionid, Map<String, dynamic> body) {
    final $url = '195.2.70.91/api/v2/mobile/promocode';
    final $headers = {
      'Cookies': sessionid,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
