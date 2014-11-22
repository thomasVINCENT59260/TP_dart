library liste_user;

import 'package:angular/angular.dart';

@Component(
    selector: 'listeUser',
    templateUrl:'liste_user.html',
    //template:'<div style="height:100%;border:1px solid grey"><input type="text" ng-model="regexp"/><div ng-repeat="user in users | userFilter:regexp" ng-bind="user.pseudo"></div></div>',
    map:const{
      'users':'=>users'
    }
)
class Liste_User{
  var users;
  String regexp='';
}