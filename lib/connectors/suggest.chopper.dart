// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$Suggest extends Suggest {
  _$Suggest([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Suggest;

  @override
  Future<Response<dynamic>> getAddressSuggest(String token, String city,
      Map<String, String> from, Map<String, String> to) {
    final $url =
        'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address';
    final $headers = {
      'Authorization': token,
    };

    final $body = <String, dynamic>{
      'query': city,
      'from_bound': from,
      'to_bound': to
    };
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
