library serialize;

import 'dart:mirrors';
import 'dart:convert';

abstract class Serializable {

  Map toJson() {
    Map mapClasse=new Map();
    Map map = new Map();
    InstanceMirror im = reflect(this);
    ClassMirror cm = im.type;
    var decls = cm.declarations.values.where((dm) => dm is VariableMirror);
    decls.forEach((dm) {
      var key = MirrorSystem.getName(dm.simpleName);
      var val = im.getField(dm.simpleName).reflectee;
      map[key] = val;
    });
    mapClasse["name"]=MirrorSystem.getName(cm.qualifiedName);
    mapClasse["fields"]=map;
    return mapClasse;
  }  

}

class Unserializable{
    static ClassMirror _getClass(dynamic o){
     List<String> split=(o['name'] as String).split('.');
     String classe=split.last;
     split.remove(split.last);
     String package=split.join('.');
     LibraryMirror lib=_getLibrary(package);
     if(lib!=null){
       var keys=lib.declarations.keys;
       for(var dec in keys){
         if(MirrorSystem.getName(dec)==classe){
           return lib.declarations[dec];
         }
       }
     }
     return null;
  }
    
  static LibraryMirror _getLibrary(String package){
    Map<Uri,LibraryMirror> library = currentMirrorSystem().libraries;
    var libMirror=library.values;
    for(var lib in libMirror){
      if(package==MirrorSystem.getName(lib.qualifiedName)){
        return lib;
      }
    }
    return null;
  }
  
  static dynamic unserialize(dynamic o){
    ClassMirror classe=_getClass(o);
    InstanceMirror im=classe.newInstance(const Symbol(''), []);
    Map m=(o['fields'] as Map);
    var v;
    for(var k in m.keys){
      v=_getValueKey(m[k]);
      im.setField(MirrorSystem.getSymbol(k), v);
    }
    return im.reflectee;
  }
  
  static dynamic _getValueKey(val){
    if(val is Map && (val as Map).containsKey("name") && (val as Map).containsKey("fields")){
      return unserialize(val);
    }
    else if(val is List){
      return (val as List).map((e)=>_getValueKey(e));
    }
    return val;
  }
}