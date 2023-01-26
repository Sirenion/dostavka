import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSock {
  getPrice(Map<String, dynamic> ad_from, Map<String, dynamic> ad_to, bool courierBring, List<dynamic> cargo, ) {
    // Dart client
    IO.Socket socket = IO.io('wss://testarea.dostavka.info/mobile/ws/price');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  getDraftPrice(String number) {
    // Dart client
    IO.Socket socket = IO.io('wss://testarea.dostavka.info/mobile/ws/price');
    socket.onConnect((_) {
      print('connect');
      socket.emit('number', number);
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  getReturn(String number) {
    // Dart client
    IO.Socket socket = IO.io('wss://testarea.dostavka.info/mobile/ws/return');
    socket.onConnect((_) {
      print('connect');
      socket.emit('number', number);
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  getPayment(String number) {
    // Dart client
    IO.Socket socket = IO.io('wss://testarea.dostavka.info/mobile/ws/pay');
    socket.onConnect((_) {
      print('connect');
      socket.emit('number', number);
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  deletePayment(String number) {
    // Dart client
    IO.Socket socket = IO.io('wss://testarea.dostavka.info/mobile/ws/delete_pay');
    socket.onConnect((_) {
      print('connect');
      socket.emit('number', number);
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

}
