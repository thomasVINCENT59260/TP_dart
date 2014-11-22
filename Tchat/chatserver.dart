library chatserver;

import 'dart:io';
import 'dart:convert';

import 'package:serialize/serialize.dart';

import 'package:Tchat/models/commande.dart';
import 'package:Tchat/models/user.dart';
import 'package:Tchat/models/message.dart';

List<User> users=new List<User>();
Map<WebSocket,User> connexion=new Map<WebSocket,User>();

void handlerMessage(message,WebSocket websocket){
  print(message);
  var o=Unserializable.unserialize(JSON.decode(message));
  if(o is Commande){
    Commande cmd=o as Commande;
    switch(cmd.cmd){
      case CMD_NEW_USER:
        connexion.keys.forEach((s)=>s.add(message));
        Commande cmd2=new Commande_connected();
        websocket.add(JSON.encode(cmd2));
        Commande cmd3=new Commande_liste_user();
        cmd3.val=users;
        websocket.add(JSON.encode(cmd3));
        connexion[websocket]=cmd.val;
        users.add(cmd.val);
        break;
      case CMD_NEW_MSG:
        connexion.keys.forEach((s)=>s.add(message));
        break;
    }
  }
}

void main() {

  String address="127.0.0.1";
  int port =50000;
  HttpServer.bind(address, port)
    .then((HttpServer server) {
      print('listening for connections on $port');

      server.listen((HttpRequest request) {
        if (request.uri.path == '/ws') {
          WebSocketTransformer.upgrade(request).then((WebSocket websocket) {
            websocket.listen((message)=>handlerMessage(message,websocket));
          });
        }
      });
    },
    onError: (error) => print("Error starting HTTP server: $error"));
}