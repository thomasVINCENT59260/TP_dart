library commande;

import 'package:serialize/serialize.dart';

const String CMD_NEW_USER="NEW_USER";
const String CMD_CONNECTED="CONNECTED";
const String CMD_NEW_MSG="NEW_MSG";
const String CMD_LIST_USER="LIST_USER";

class Commande extends Serializable{
  String cmd;
  dynamic val;
}

class Commande_new_user extends Serializable implements Commande{
  String cmd;
  dynamic val;
  
  Commande_new_user(){
    cmd=CMD_NEW_USER;
  }
}

class Commande_connected extends Serializable implements Commande{
  String cmd;
  dynamic val;
  
  Commande_connected(){
      cmd=CMD_CONNECTED;
      val="200 connected";
  }
}

class Commande_liste_user extends Serializable implements Commande{
  String cmd;
  dynamic val;
    
  Commande_liste_user(){
    cmd=CMD_LIST_USER;
  }
}

class Commande_new_message extends Serializable implements Commande{
  String cmd;
  dynamic val;
    
  Commande_new_message(){
    cmd=CMD_NEW_MSG;
  }
}