library wysiwyg;

import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:wysiwyg/button.dart';

@Component(
    selector: 'wysiwyg',
    template:'<div style="height:20%"><boldBtn></boldBtn><italicBtn></italicBtn><underlineBtn></underlineBtn></div><div contenteditable="true" id="contentWysiwyg" style="width:100%;height:80%;border:1px solid grey"></div><button type="button" ng-click="send()">Envoyer</button>',
    map:const {
      'msg':'<=>msg',
      'handler':'&handler'
    },
    useShadowDom: false
)
class Wysiwyg{
  var msg;
  dynamic handler;
  
  void handleText(Button btn){
    Selection sel=window.getSelection();
    Range range=sel.getRangeAt(0);
    DocumentFragment df=range.extractContents();
    df.setInnerHtml(btn.getStartBBCode()+df.innerHtml+btn.getEndBBCode());
    range.insertNode(df);
  }
  
  void send(){
    msg=querySelector("#contentWysiwyg").innerHtml;
    new Timer(new Duration(milliseconds: 0), () {
          handler();
    });
    querySelector("#contentWysiwyg").setInnerHtml("");
  }
}

class WysiwygModule extends Module{
  WysiwygModule(){
    bind(Wysiwyg);
    bind(Bold);
    bind(Italic);
    bind(Underline);
  }
}
