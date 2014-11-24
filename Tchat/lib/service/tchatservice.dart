library tchat_service;

import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';

import 'package:Tchat/service/websocket.dart';
import 'package:Tchat/models/commande.dart';
import 'package:Tchat/models/message.dart';
import 'package:Tchat/models/user.dart';

@Injectable()
class Tchat extends ListenerWebSocket{
  Websocket_Service socket;
  String msg;
  List<Message> received;
  List<User> users;
  User user;
  
  Tchat(Websocket_Service this.socket){
    user=new User();
    msg="";
    received=new List<Message>();
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
        case CMD_NEW_MSG:
          received.add(cmd.val);
          break;
      }
      
    }
  }
  
  void sendMessage(){
      Commande cmd=new Commande_new_message();
      Message msg=new Message();
      msg.message=this.msg;
      msg.sender=user;
      DateTime date=new DateTime.now();
      msg.dateSend=date.day.toString()+"-"+date.month.toString()+"-"+date.year.toString()+" "+date.hour.toString()+":"+date.minute.toString();
      cmd.val=msg;
      socket.send(JSON.encode(cmd));
  }
  
  void connect(){
    Commande cmd=new Commande_new_user();
    cmd.val=user;
    socket.send(JSON.encode(cmd));
  }
  
  void isConnect(){
    window.location.hash="#/tchat";
  }
}