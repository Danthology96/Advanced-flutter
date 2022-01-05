import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket = IO.io('https://band-name-socket-app.herokuapp.com/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.onConnect((_) {
      print('conectado en celular');
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      print('disconnected');

      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket.on('new-message', (payload) {
      print('nuevo mensaje: $payload');
    });
  }

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;
}
