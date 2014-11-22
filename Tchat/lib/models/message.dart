library message;

import 'package:serialize/serialize.dart';

import 'package:Tchat/models/user.dart';

class Message extends Serializable{
  User sender;
  String message;
  String dateSend;
}