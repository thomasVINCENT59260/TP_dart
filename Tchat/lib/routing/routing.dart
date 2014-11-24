library routing;

import 'package:angular/angular.dart';

void routeInitializer(Router router, RouteViewFactory views){
  views.configure({
      'login': ngRoute(
          path: '/login',
          view: 'view/login.html',
          defaultRoute: true),
      'tchat': ngRoute(
          path: '/tchat',
          view: 'view/chatclient.html'
      )
    });
}