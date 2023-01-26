import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WSClient{
  getPrice(){
    var data = "";
    WebSocketChannel channel = IOWebSocketChannel.connect("wss://testarea.dostavka.info/mobile/ws/price");
    channel.sink.add(data);
    var info;
    channel.stream.listen((data) {
      print("new data ${data}");
      info = new Map<String, dynamic>.from(data);
      print("INFO ${info.toString()}");
    });

    return info;
  }

}