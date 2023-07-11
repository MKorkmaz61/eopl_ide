import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/services.dart';

class GL {
  static var guest_mode = false;
  static var local_lang = "tr-TR";
  static var grid_axis = 2;
  static var user_token = "";
}

class Language_Automata {
  static Language_Automata instance = Language_Automata._interval();

  String lang = "TR";

  Map<String, dynamic> lang_json = <String, dynamic>{};

  factory Language_Automata() {
    return instance;
  }

  Language_Automata._interval();

  Future<void> Language_Init() async {
    var languages = await Devicelocale.preferredLanguages;

    GL.local_lang = languages![0].split('-')[0];

    String langStr = await rootBundle.loadString('assets/languages/languages.json');
    lang_json = jsonDecode(langStr);

    if (GL.local_lang == "tr") {
      // Turkish
      lang = "TR";
    } else {
      // English
      lang = "EN";
    }
  }

  String Get_Int_Text(String uniqueName) {
    try {
      var content = lang_json.entries
          .where((element) => element.key == uniqueName)
          .first;

      var val = content.value[lang];

      return val;
    } catch (ex) {
      return "#Error";
    }
  }
}
