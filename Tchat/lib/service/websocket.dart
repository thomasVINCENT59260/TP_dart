library websocket_service;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';

import 'package:serialize/serialize.dart';

abstract class ListenerWebSocket{
  void dataReceive(dynamic o);
}

@Injectable()
class Websocket_Service{
  WebSocket ws;
  List<ListenerWebSocket> listeners;
  
  Websocket_Service(){
    listeners=new List<ListenerWebSocket>();
  }
  
  void addListener(ListenerWebSocket o){
    listeners.add(o);
  }

  void initWebSocket(String address,[int retrySeconds = 2]) {
    var reconnectScheduled = false;

    ws = new WebSocket(address);

    void scheduleReconnect() {
      if (!reconnectScheduled) {
        new Timer(new Duration(milliseconds: 1000 * retrySeconds), () => initWebSocket(address,retrySeconds * 2));
      }
      reconnectScheduled = true;
    }

    ws.onClose.listen((e) {
      scheduleReconnect();
    });

    ws.onError.listen((e) {
      scheduleReconnect();
    });

    ws.onMessage.listen((MessageEvent e) {
      dynamic o=Unserializable.unserialize(JSON.decode(e.data));
      listeners.forEach((l)=>l.dataReceive(o));
    });
  }
  
  void send(String msg){
    if(ws!=null && ws.readyState==WebSocket.OPEN){
      ws.send(msg);
    }
  }
}