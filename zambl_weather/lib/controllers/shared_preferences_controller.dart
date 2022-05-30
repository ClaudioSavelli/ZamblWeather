import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController{
  String name = 'Saved cities';

  SharedPreferencesController() {
    save("Lisbon");
    save("Porto");
  }

   void save(String value) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(name);
    if(data != null){
      if(!data.contains(value)){
        data.add(value);
        await prefs.setStringList(name, data);
      }
    } else {
      await prefs.setStringList(name, <String>[value]);
    }
    print(prefs.getStringList(name)?.toList());
  }

  Future<List<String>?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(name);
  }

  void remove(String toRemove) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList(name);
    if (data != null && toRemove != "Porto" && toRemove != "Lisbon") {
      data.remove(toRemove);
      prefs.setStringList(name, data);
    }
  }
}
