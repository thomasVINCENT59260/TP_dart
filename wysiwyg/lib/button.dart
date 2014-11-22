library wysiwyg;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:wysiwyg/wysiwyg.dart';

/**
 * Class represent a button for the navigation of the wysiwyg
 */
abstract class Button{
  String _start;
  String _end;
  String title;

  String getStartBBCode()=>_start;
  String getEndBBCode()=>_end;
  
  void action(MouseEvent e);
}

@Component(
    selector: 'boldBtn',
    template:'<button ng-click="action(\$event)">{{title}}</button>'
)
class Bold extends Button{
  
  Wysiwyg p;
  
  Bold(Wysiwyg this.p){
    title="B";
    _start="<b>";
    _end="</b>";
  }
  
  void action(MouseEvent e){
    p.handleText(this);
  }
}

@Component(
    selector: 'italicBtn',
    template:'<button ng-click="action(\$event)">{{title}}</button>'
)
class Italic extends Button{
  
  Wysiwyg p;
  
  Italic(Wysiwyg this.p){
    title="I";
    _start="<i>";
    _end="</i>";
  }
  
  void action(MouseEvent e){
    p.handleText(this);
  }
}

@Component(
    selector: 'underlineBtn',
    template:'<button ng-click="action(\$event)">{{title}}</button>'
)
class Underline extends Button{
  
  Wysiwyg p;
  
  Underline(Wysiwyg this.p){
    title="U";
    _start="<u>";
    _end="</u>";
  }
  
  void action(MouseEvent e){
    p.handleText(this);
  }
}

@Component(
    selector: 'imageBtn',
    template:'<button ng-click="action(\$event)">{{title}}</button><input type="file" ng-model="files"/>'
)
class Image extends Button{
  Wysiwyg p;
  String files;
    
    Image(Wysiwyg this.p){
      title="Img";
      _start="<img src=\"";
      _end="\"/>";
    }
    
    void action(MouseEvent e){
      print(files);
    }
}