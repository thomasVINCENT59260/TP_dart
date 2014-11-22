library select_user;

import 'package:angular/angular.dart';

import 'package:Tchat/models/user.dart';

@Formatter(name: 'userFilter')
class UserFormatter{
  call(recipeList, filter) {
      if (recipeList is Iterable && filter is String) {
        print(recipeList);
        var v=recipeList.where((u)=>new RegExp(filter).hasMatch((u as User).pseudo));
        print(v);
        return v;
      }
      return const [];
    }
}