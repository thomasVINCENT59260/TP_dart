import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:wysiwyg/wysiwyg.dart';

import 'package:Tchat/service/websocket.dart';
import 'package:Tchat/service/tchatservice.dart';
import 'package:Tchat/routing/routing.dart';

class TchatModule extends Module{
  TchatModule(){
    bind(Tchat);
    bind(Websocket_Service);
    bind(RouteInitializerFn, toValue: routeInitializer);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }
}

void main() {
  applicationFactory()
          .addModule(new TchatModule())
          .addModule(new WysiwygModule())
          .rootContextType(Tchat)
          .run();
}
