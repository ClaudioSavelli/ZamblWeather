import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferencesController{
  String name = 'Saved cities';

   void save(String value) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(name);
    if(data != null){
      data.add(value);
      await prefs.setStringList(name, data);
    } else {
      await prefs.setStringList(name, <String>[value]);
    }
    print(prefs.getStringList(name)?.toList());
  }

  Future<List<String>?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(name);
  }

  void remove(String toRemove) async{
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(name);
    if (data != null){
      data.remove(toRemove);
      prefs.setStringList(name, data);
    }
  }
}
