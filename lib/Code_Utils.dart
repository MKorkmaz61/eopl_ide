import 'dart:io';

class EOPL_Result {
  String out = "";
  String err = "";
}

enum Screen_Types { SCREEN_TYPE_CODE_EDITOR, SCREEN_TYPE_AST, SCREEN_TYPE_ENV }

class Code_Utils {
  static final Code_Utils instance = Code_Utils._internal();
  String GL_LANG_DIR_PATH = "";
  String GL_SELECTED_LANG = "";
  String GL_RACKET_EXEC_PATH = "";

  List<String> GL_EXP_LIST = List.empty(growable: true);
  List<List<List<String>>> GL_ENV_LIST = List.empty(growable: true);
  List<Map<String, String>> GL_STO_MAP_LIST = List.empty(growable: true);

  factory Code_Utils() {
    return instance;
  }

  Code_Utils._internal();

  Future<EOPL_Result> Execute_Code(String sourceCode) async {
    String codeSrcPath = "$GL_LANG_DIR_PATH\\$GL_SELECTED_LANG\\result.scm";
    if (Platform.isMacOS || Platform.isLinux) {
      codeSrcPath = "$GL_LANG_DIR_PATH/$GL_SELECTED_LANG/result.scm";
    }
    String srcCode =
        "#lang racket\n(require \"top.scm\")\n(require \"globalstack.scm\")\n(run \"$sourceCode\")\n(define print-element (lambda (i) (pretty-print i) (display \"\\n*element*\\n\")))\n(display \"\\n**split**\\n\")\n(map print-element (get-expstack))\n(display \"\\n**split**\\n\")\n(map print-element (get-envstack))\n(display \"\\n**split**\\n\")\n(map print-element (get-stostack))\n";

    File codeFile = File(codeSrcPath);
    codeFile.writeAsString(srcCode);

    EOPL_Result eoplResult = EOPL_Result();

    Process.run(GL_RACKET_EXEC_PATH, [codeSrcPath]).then((ProcessResult pr) {
      eoplResult.out = pr.stdout;
      eoplResult.err = pr.stderr;
    });

    return eoplResult;
  }
}
