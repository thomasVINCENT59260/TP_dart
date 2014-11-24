library tchat_service;

import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:Tchat/service/websocket.dart';
import 'package:Tchat/models/commande.dart';
import 'package:Tchat/models/user.dart';

@Injectable()
class Tchat extends ListenerWebSocket{
  Websocket_Service socket;
  List<User> users;
  User user;
  
  Tchat(Websocket_Service this.socket){
    user=new User();
    users=new List<User>();
    socket.addListener(this);
    socket.initWebSocket('ws://127.0.0.1:50000/ws');
  }
  
  void dataReceive(dynamic o){
    if(o is Commande){
      Commande cmd=o as Commande;
      switch(cmd.cmd){
        case CMD_LIST_USER:
          users=(cmd.val as Iterable).toList();
          break;
        case CMD_CONNECTED:
          isConnect();
          break;
        case CMD_NEW_USER:
          users.add(cmd.val);
          break;
      }
      
    }
  }
  
  void isConnect(){
    window.location.hash="#/tchat";
  }
}
