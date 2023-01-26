// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$Api extends Api {
  _$Api([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Api;

  @override
  Future<Response<dynamic>> Login(Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> SendSMS(Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> Logout(
      String sessionid, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/logout';
    final $headers = {
      'Cookie': sessionid,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSuggestions() {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/suggest';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUser(String sessionid, String username) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/settings';
    final $params = <String, dynamic>{'username': username};
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> setUser(
      String sessionid, String csrf, Map<String, dynamic> data) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/settings';
    final $params = data;
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $request = Request('PATCH', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFIO(String sessionid, String username) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/settings/user';
    final $params = <String, dynamic>{'username': username};
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> setFIO(
      String sessionid, String csrf, Map<String, dynamic> data) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/settings/user';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = data;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPassport(String sessionid, String username) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/passport';
    final $params = <String, dynamic>{'username': username};
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> setPassport(
      String sessionid, String csrf, Map<String, dynamic> data) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/passport';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = data;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAddress(String sessionid, String username) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/address';
    final $params = <String, dynamic>{'username': username};
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> setAddress(
      String sessionid, String csrf, Map<String, dynamic> data) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/address';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = data;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createAddress(
      String sessionid, String csrf, Map<String, dynamic> data) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/address';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = data;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeAddress(
      String sessionid, String csrf, Map<String, dynamic> data) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/address';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = data;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSecurityKey(
      String sessionid, Map<String, dynamic> body) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/security';
    final $headers = {
      'Cookie': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> patchSecurityKey(
      String sessionid, String csrf, Map<String, dynamic> data) {
    final $url =
        'https://testarea.dostavka.info/api/v2/mobile/settings/security';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = data;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOffices(Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/offices';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllOffices() {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/offices';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDrafts(String sessionid, String way) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/drafts';
    final $params = <String, dynamic>{'way': way};
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDraft(String sessionid, String number) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/draft';
    final $params = <String, dynamic>{'number': number};
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createDraft(
      String sessionid, String csrf, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/draft';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeDraft(
      String sessionid, String csrf, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/draft';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = body;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteDraft(
      String sessionid, String csrf, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/draft';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = body;
    final $request =
        Request('DELETE', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCargo(
      String sessionid, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/cargo';
    final $params = body;
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createCargo(
      String sessionid, String csrf, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/cargo';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeCargo(
      String sessionid, String csrf, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/cargo';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = body;
    final $request =
        Request('PATCH', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteCargo(
      String sessionid, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/cargo';
    final $headers = {
      'Cookie': sessionid,
    };

    final $body = body;
    final $request =
        Request('DELETE', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOrders(
      String sessionid, String way, String condition) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/orders';
    final $params = <String, dynamic>{'way': way, 'condition': condition};
    final $headers = {
      'Cookie': sessionid,
    };

    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOrder(
      String sessionid, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/order';
    final $headers = {
      'Cookie': sessionid,
    };

    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPushToken(
      String sessionid, String csrf, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/push_token';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> usePromocode(
      String sessionid, String csrf, Map<String, dynamic> body) {
    final $url = 'https://testarea.dostavka.info/api/v2/mobile/promocode';
    final $headers = {
      'Cookie': sessionid,
      'X-CSRFToken': csrf,
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
