import 'dart:io';

import 'package:eopl_ide/Code_Examples.dart';
import 'package:eopl_ide/TextIO.dart' as EOPL_IO;
import 'package:eopl_ide/Node.dart' as EOPL_NODE;

import 'package:eopl_ide/screens/elements/Examples.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:graphview/GraphView.dart';
import 'package:highlight/languages/dart.dart';
import 'package:eopl_ide/Responsive.dart';
import 'package:eopl_ide/Code_Utils.dart';
import 'package:eopl_ide/base/Colors.dart';
import 'package:eopl_ide/base/TextStyles.dart';
import 'package:eopl_ide/screens/elements/Settings.dart';
import 'package:eopl_ide/screens/elements/Status_Bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CodeEditorMainScreen extends StatefulWidget {
  const CodeEditorMainScreen({Key? key}) : super(key: key);

  @override
  State<CodeEditorMainScreen> createState() => _CodeEditorMainScreenState();
}

class _CodeEditorMainScreenState extends State<CodeEditorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return const TripleResponsiveLayoutBuilder(
      mobileLayout: CodeEditorMainScreenDesktop(),
      tabletLayout: CodeEditorMainScreenDesktop(),
      desktopLayout: CodeEditorMainScreenDesktop(),
    );
  }
}

class CodeEditorMainScreenMobile extends StatefulWidget {
  const CodeEditorMainScreenMobile({Key? key}) : super(key: key);

  @override
  State<CodeEditorMainScreenMobile> createState() =>
      _CodeEditorMainScreenMobileState();
}

class _CodeEditorMainScreenMobileState
    extends State<CodeEditorMainScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CodeEditorMainScreenDesktop extends StatefulWidget {
  const CodeEditorMainScreenDesktop({Key? key}) : super(key: key);

  @override
  State<CodeEditorMainScreenDesktop> createState() =>
      _CodeEditorMainScreenDesktopState();
}

class _CodeEditorMainScreenDesktopState
    extends State<CodeEditorMainScreenDesktop> {
  late bool isSettingsVisible;
  late bool isExamplesVisible;

  CodeController? _ctrlCodeField;
  final TextEditingController _ctrlTerminal = TextEditingController();

  final CodeController _ctrlCodeENVField = CodeController();

  final TextEditingController _ctrlENV = TextEditingController();
  final TextEditingController _ctrlStore = TextEditingController();

  late int indexLang;
  late String currentLangDisplay;
  List langNamesDisplay = ["No Languages Provided"];
  FocusNode focus_node_code = FocusNode();
  FocusNode focus_node_terminal = FocusNode();

  FocusNode focus_node_code_env = FocusNode();
  FocusNode focus_node_env = FocusNode();
  FocusNode focus_node_store = FocusNode();

  Screen_Types screen_type = Screen_Types.SCREEN_TYPE_CODE_EDITOR;
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  int _value = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, Get_Languages_From_Mem_Dir);

    focus_node_code.addListener(() {
      if (focus_node_code.hasFocus == true &&
          (isExamplesVisible == true || isSettingsVisible == true)) {
        setState(() {
          isExamplesVisible = false;
          isSettingsVisible = false;
        });
      }
    });
    focus_node_terminal.addListener(() {
      if (focus_node_terminal.hasFocus == true &&
          (isExamplesVisible == true || isSettingsVisible == true)) {
        setState(() {
          isExamplesVisible = false;
          isSettingsVisible = false;
        });
      }
    });

    focus_node_code_env.addListener(() {
      if (focus_node_code_env.hasFocus == true &&
          (isExamplesVisible == true || isSettingsVisible == true)) {
        setState(() {
          isExamplesVisible = false;
          isSettingsVisible = false;
        });
      }
    });

    focus_node_env.addListener(() {
      if (focus_node_env.hasFocus == true &&
          (isExamplesVisible == true || isSettingsVisible == true)) {
        setState(() {
          isExamplesVisible = false;
          isSettingsVisible = false;
        });
      }
    });

    focus_node_store.addListener(() {
      if (focus_node_store.hasFocus == true &&
          (isExamplesVisible == true || isSettingsVisible == true)) {
        setState(() {
          isExamplesVisible = false;
          isSettingsVisible = false;
        });
      }
    });

    isSettingsVisible = false;
    isExamplesVisible = false;
    indexLang = 0;
    currentLangDisplay = langNamesDisplay[0];

    const source = "letrec f(x) = -(x,1) in (f 33)}";

    _ctrlCodeField = CodeController(
      text: source,
      language: dart,
      stringMap: {
        "import": const TextStyle(color: Colors.deepOrangeAccent),
        "class": const TextStyle(color: Colors.deepOrangeAccent),
        "extends": const TextStyle(color: Colors.deepOrangeAccent),
        "const": const TextStyle(color: Colors.deepOrangeAccent),
        "void": const TextStyle(color: Colors.deepOrangeAccent),
        "super": const TextStyle(color: Colors.deepOrangeAccent),
        "late": const TextStyle(color: Colors.deepOrangeAccent),
        "final": const TextStyle(color: Colors.deepOrangeAccent),
        "return": const TextStyle(color: Colors.deepOrangeAccent),
        "print": const TextStyle(color: Colors.deepOrangeAccent),
        "proc": const TextStyle(color: Colors.deepOrangeAccent),
        "let": const TextStyle(color: Colors.deepOrangeAccent),
        "define": const TextStyle(color: Colors.deepOrangeAccent),
        "newpair": const TextStyle(color: Colors.deepOrangeAccent),
        "main": const TextStyle(color: Colors.lightBlue),
        "letrec": const TextStyle(color: Colors.lightBlue),
        "function": const TextStyle(color: Colors.lightBlue),
        "begin": const TextStyle(color: Colors.lightBlue),
        "end": const TextStyle(color: Colors.lightBlue),
        "true": const TextStyle(color: Colors.amberAccent),
        "false": const TextStyle(color: Colors.amberAccent),
        "int": const TextStyle(color: Colors.amberAccent),
        "double": const TextStyle(color: Colors.amberAccent),
        "String": const TextStyle(color: Colors.amberAccent),
        "if": const TextStyle(color: grayRGB140),
        "else": const TextStyle(color: grayRGB140),
      },
      patternMap: {
        r'".*"': const TextStyle(color: Colors.green),
        r'[0-9]': const TextStyle(color: Colors.greenAccent),
      },
    );
  }

  Future<void> Get_Languages_From_Mem_Dir() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? racketExecPath = prefs.getString('eopl_racket_ex_file_path');

      if (racketExecPath != null) {
        Code_Utils.instance.GL_RACKET_EXEC_PATH = racketExecPath;
      }

      String? langDir = prefs.getString('eopl_languages_dir');

      if (langDir != null) {
        Code_Utils.instance.GL_LANG_DIR_PATH = langDir;
        var entities =
            await Directory(langDir).list(followLinks: false).toList();
        langNamesDisplay.clear();

        for (var entity in entities) {
          var entityName =
              entity.path.split('\\').toList().reversed.elementAt(0);

          if (Platform.isMacOS || Platform.isLinux) {
            entityName = entity.path.split('/').toList().reversed.elementAt(0);
          }

          // if file name starts with '.', this is secret file, just ignore it
          if (entityName.characters.first != ".") {
            langNamesDisplay.add(entityName);
          }
        }
        setState(() {
          currentLangDisplay = langNamesDisplay[0];
        });
        Code_Utils.instance.GL_SELECTED_LANG = currentLangDisplay;
      }
    } catch (ex) {
      print(ex);
    }
  }

  void Update_Task() async {
    await Get_Languages_From_Mem_Dir();
  }

  EOPL_IO.Stack<String> Parse_Store(EOPL_IO.Stack<String> stack) {
    while (EOPL_IO.TextIO.moreInput()) {
      EOPL_IO.TextIO.skipBlanks();
      String nc = EOPL_IO.TextIO.peek();
      if (nc == '(') {
        String para = EOPL_IO.TextIO.getBetweenParentheses();
        EOPL_IO.TextIO.pushBufferAndFillWith(para, 0);

        EOPL_IO.TextIO.getChar(); //get rid of the '('
        String word = EOPL_IO.TextIO.getWord();
        if (word.toLowerCase() == "list") {
          nc = EOPL_IO.TextIO.getChar();
          if (EOPL_IO.TextIO.isDigit(nc, 0)) {
            EOPL_IO.TextIO.rewind(1);
            int location = EOPL_IO.TextIO.getInt();

            EOPL_IO.TextIO.skipBlanks();
            nc = EOPL_IO.TextIO.peek();
            if (nc == '(') {
              String value = EOPL_IO.TextIO.getBetweenParentheses();
              stack.push(location.toString());
              stack.push(value);

              //Pop the most-previous string and fill the buffer with it.
              EOPL_IO.TextIO.popBufferAndFill();
            }
          }
        }
      } else if (nc == ')') {
        // This is the last ')' character of the string (list (list 'i (num-val 5)))
        return stack;
      }
    }

    return stack;
  }

  void Fill_Sto_List(List<String> stoList) {
    Code_Utils.instance.GL_STO_MAP_LIST.clear();

    for (int i = 0; i < stoList.length - 1; i++) {
      String store = stoList[i]; //The environment as a string

      if (i > 0) {
        if (store.toLowerCase() == stoList[i - 1].toLowerCase()) {
          Code_Utils.instance.GL_STO_MAP_LIST.add(Code_Utils
              .instance.GL_STO_MAP_LIST
              .elementAt(Code_Utils.instance.GL_STO_MAP_LIST.length - 1));
          continue;
        }
      }

      EOPL_IO.Stack<String> stoStack = EOPL_IO.Stack<String>();
      Map<String, String> stoMap =
          <String, String>{}; //The hashmap that will hold the environment
      EOPL_IO.TextIO.fillBuffer(store, 0);

      String nc = EOPL_IO.TextIO.getChar();
      if (nc == '(') {
        String word = EOPL_IO.TextIO.getWord();
        if (word.toLowerCase() == "list") {
          stoStack = Parse_Store(EOPL_IO.Stack<String>());
        }
      }

      if (stoStack.length % 2 == 0) {
        while (stoStack.isNotEmpty) {
          String value = stoStack.pop();
          String identifier = stoStack.pop();
          stoMap[identifier] = value;
        }
      }

      Code_Utils.instance.GL_STO_MAP_LIST.add(stoMap);
    }
  }

  void Exec_Code() async {
    EasyLoading.show(status: 'Running...');
    EOPL_Result eoplResult =
        await Code_Utils.instance.Execute_Code(_ctrlCodeField!.text);
    await Future.delayed(const Duration(seconds: 2));
    EasyLoading.dismiss();

    if (eoplResult.err != "") {
      EasyLoading.showError("Unhandled exception!");
    } else {
      EasyLoading.showSuccess("Build successful!");
    }
    print(eoplResult.err);

    var splitResult = eoplResult.out.split("**split**");
    var expSplitResult = splitResult[1].split("*element*");
    Code_Utils.instance.GL_EXP_LIST = expSplitResult;

    EOPL_IO.TextIO.fillBuffer(Code_Utils.instance.GL_EXP_LIST.elementAt(0), 0);
    EOPL_NODE.Node<String> tree = parseASTString(EOPL_NODE.Node(""));
    graph.edges.clear();
    graph.nodes.clear();
    Set_AST(tree);
    var envSplitResult = splitResult[2].trim().split("*element*");
    Fill_Env_List(envSplitResult);

    var stoSplitResult = splitResult[3].split("*element*");

    Fill_Sto_List(stoSplitResult);
    Update_Slider(0);

    setState(() {
      builder
        ..siblingSeparation = (100)
        ..levelSeparation = (150)
        ..subtreeSeparation = (150)
        ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
      _ctrlTerminal.text = splitResult[0].trimLeft().trimRight();
    });
  }

  void Fill_Env_List(List<String> envArray) {
    Code_Utils.instance.GL_ENV_LIST.clear();

    for (int i = 0; i < envArray.length - 1; i++) {
      String environment = envArray[i]; //The environment as a string

      //before starting to parse the given environment string compare it to the previous one, they might be same.
      //so we will not parse the same string again.. we just duplicate it's result.

      if (i > 0) {
        if (environment.toLowerCase() == envArray[i - 1].toLowerCase()) {
          Code_Utils.instance.GL_ENV_LIST.add(Code_Utils.instance.GL_ENV_LIST
              .elementAt(Code_Utils.instance.GL_ENV_LIST.length - 1));
          continue;
        }
      }

      //The stack that will hold the environment before filling the hashmap. This stack is necessary assuming that
      //in scheme side a new variable is appended at the beginning of a an environment list, so that means
      //Being at most left for a key-value pair in an environment list means being the most recent key-value pair.
      //Since we analyze the environment array starting from the left-most character than we need a stack to keep
      //the track that which variable is newer than the other. This is situation is critical when a variable is
      //overrode in an environment.
      EOPL_IO.Stack<String> envStack = EOPL_IO.Stack<String>();
      List<List<String>> envMap = List.empty(growable: true);
      EOPL_IO.TextIO.fillBuffer(environment, 0);

      String nc = EOPL_IO.TextIO.getChar();
      if (nc == '(') {
        String word = EOPL_IO.TextIO.getWord();

        if (word.toLowerCase() == "list") {
          envStack = Parse_Env(EOPL_IO.Stack<String>());
        } else if (word.toLowerCase() == "extend-env" ||
            word.toLowerCase() == "extend-env-rec" ||
            word.toLowerCase() == "extend-env-rec*") {
          //Rewind the text to its beginning
          EOPL_IO.TextIO.rewind(EOPL_IO.TextIO.getPos());
          envStack = Parse_ENV_Extended(EOPL_IO.Stack<String>());
        }
      }

      if (envStack.length % 2 == 0) {
        while (envStack.isNotEmpty) {
          String value = envStack.pop();
          String identifier = envStack.pop();
          List<String> idValPairs = List.empty(growable: true);
          idValPairs.add(identifier);
          idValPairs.add(value);
          envMap.insert(0, (idValPairs));
        }
      }
      Code_Utils.instance.GL_ENV_LIST.add(envMap);
    }
  }

  EOPL_IO.Stack<String> Parse_Env(EOPL_IO.Stack<String> stack) {
    while (EOPL_IO.TextIO.moreInput()) {
      EOPL_IO.TextIO.skipBlanks();
      String nc = EOPL_IO.TextIO.peek();
      if (nc == '(') {
        String para = EOPL_IO.TextIO.getBetweenParentheses();
        EOPL_IO.TextIO.pushBufferAndFillWith(para, 0);

        EOPL_IO.TextIO.getChar(); //get rid of the '('
        String word = EOPL_IO.TextIO.getWord();
        if (word.toLowerCase() == "list") {
          nc = EOPL_IO.TextIO.getChar();
          if (nc == '\'') {
            String identifier = EOPL_IO.TextIO.getWord();

            EOPL_IO.TextIO.skipBlanks();
            nc = EOPL_IO.TextIO.peek();
            if (nc == '(') {
              String value = EOPL_IO.TextIO.getBetweenParentheses();
              stack.push(identifier);
              stack.push(value);

              //Pop the most-previous string and fill the buffer with it.
              EOPL_IO.TextIO.popBufferAndFill();
            }
          }
        }
      } else if (nc == ')') {
        // This is the last ')' character of the string (list (list 'i (num-val 5)))
        return stack;
      }
    }

    return stack;
  }

  EOPL_IO.Stack<String> Parse_ENV_Extended(EOPL_IO.Stack<String> stack) {
    File file = File(
        "${Code_Utils.instance.GL_LANG_DIR_PATH}\\${Code_Utils.instance.GL_SELECTED_LANG}\\store.scm");

    if (Platform.isMacOS || Platform.isLinux) {
      file = File(
          "${Code_Utils.instance.GL_LANG_DIR_PATH}/${Code_Utils.instance.GL_SELECTED_LANG}/store.scm");
    }
    bool hasStore = file.existsSync();

    while (EOPL_IO.TextIO.moreInput()) {
      EOPL_IO.TextIO.skipBlanks();
      String nc = EOPL_IO.TextIO.peek();
      if (nc == '(') {
        EOPL_IO.TextIO.getChar(); //get rid of the '('
        String word = EOPL_IO.TextIO.getWord();

        if (word.toLowerCase() == "extend-env") {
          nc = EOPL_IO.TextIO
              .getChar(); //this must be a single quote (') character.
          if (nc == '\'') {
            String identifier = EOPL_IO.TextIO.getWord();
            stack.push(identifier);

            EOPL_IO.TextIO.skipBlanks();
            if (hasStore) {
              int pointer = EOPL_IO.TextIO.getInt();
              stack.push(pointer.toString());
            } else {
              if (EOPL_IO.TextIO.peek() == '(') {
                String value = EOPL_IO.TextIO.getBetweenParentheses();
                stack.push(value.toString());
              } else {
                throw Exception(
                    "parseEnvAsExtended; expected '(' before value.");
              }
            }
          } else {
            throw Exception(
                "parseEnvAsExtended; expected single quote (') before identifier.");
          }
        } else if (word.toLowerCase() == "extend-env-rec") {
          nc = EOPL_IO.TextIO
              .getChar(); //this must be a single quote (') character.
          if (nc == '\'') {
            String identifier = EOPL_IO.TextIO.getWord();
            stack.push(identifier);

            if ((nc = EOPL_IO.TextIO.getChar()) == '\'') {
              String argument = EOPL_IO.TextIO.getWord();
            } else {
              throw Exception(
                  "parseEnvAsExtended; expected an argument in the definition.");
            }

            EOPL_IO.TextIO.skipBlanks();
            if (EOPL_IO.TextIO.peek() == '(') {
              String value = EOPL_IO.TextIO.getBetweenParentheses();
              stack.push(value.toString());
            } else {
              throw Exception("parseEnvAsExtended; expected '(' before value.");
            }
          } else {
            throw Exception(
                "parseEnvAsExtended; expected single quote (') before identifier.");
          }
        } else if (word.toLowerCase() == "extend-env-rec*") {
          EOPL_IO.Stack<String> identifiers = EOPL_IO.Stack<String>();
          EOPL_IO.Stack<String> arguments = EOPL_IO.Stack<String>();
          EOPL_IO.Stack<String> bodies = EOPL_IO.Stack<String>();

          nc = EOPL_IO.TextIO
              .getChar(); //this must be a single quote (') character.

          // Read and store the identifiers
          if (nc == '\'') {
            if (EOPL_IO.TextIO.peek() == '(') {
              String identifierString = EOPL_IO.TextIO.getBetweenParentheses();
              EOPL_IO.TextIO.pushBufferAndFillWith(identifierString, 0);

              while (
                  EOPL_IO.TextIO.peek() != ')' && EOPL_IO.TextIO.moreInput()) {
                String id = EOPL_IO.TextIO.getWord();
                if (id.isEmpty) {
                  EOPL_IO.TextIO.readChar();
                } else {
                  identifiers.push(id);
                }
              }

              if (EOPL_IO.TextIO.peek() == ')') {
                EOPL_IO.TextIO.getChar();
              } else {
                throw Exception(
                    "parseEnvAsExtended; expected ')' before after identifiers.");
              }
            } else {
              throw Exception(
                  "parseEnvAsExtended; expected single quote '(' before identifiers.");
            }
          } else {
            throw Exception(
                "parseEnvAsExtended; expected single quote (') before identifiers.");
          }

          //Pop the buffer
          EOPL_IO.TextIO.popBufferAndFill();

          // Read and store the arguments
          EOPL_IO.TextIO.skipBlanks();
          nc = EOPL_IO.TextIO.getChar();
          if (nc == '\'') {
            if (EOPL_IO.TextIO.peek() == '(') {
              String argumentString = EOPL_IO.TextIO.getBetweenParentheses();
              EOPL_IO.TextIO.pushBufferAndFillWith(argumentString, 0);

              while (
                  EOPL_IO.TextIO.peek() != ')' && EOPL_IO.TextIO.moreInput()) {
                String id = EOPL_IO.TextIO.getWord();
                if (id.isEmpty) {
                  EOPL_IO.TextIO.readChar();
                } else {
                  arguments.push(id);
                }
              }

              if (EOPL_IO.TextIO.peek() == ')') {
                EOPL_IO.TextIO.getChar();
              } else {
                throw Exception(
                    "parseEnvAsExtended; expected ')' before after arguments.");
              }
            } else {
              throw Exception(
                  "parseEnvAsExtended; expected '(' before arguments.");
            }
          } else {
            throw Exception(
                "parseEnvAsExtended; expected single quote (') before arguments.");
          }

          //Pop the buffer
          EOPL_IO.TextIO.popBufferAndFill();

          //Read and store the function bodies
          EOPL_IO.TextIO.skipBlanks();
          nc = EOPL_IO.TextIO.getChar();
          if (nc == '(') {
            String listWord = EOPL_IO.TextIO.getWord();
            if (listWord.toLowerCase() == "list") {
              nc = EOPL_IO.TextIO.getChar();
              while (nc != ')' && EOPL_IO.TextIO.moreInput()) {
                if (nc == '(') {
                  EOPL_IO.TextIO.rewind(1);
                  String body = EOPL_IO.TextIO.getBetweenParentheses();
                  bodies.push(body);
                }

                nc = EOPL_IO.TextIO.getChar();
              }

              if (nc != ')') {
                throw Exception(
                    "parseEnvAsExtended; expected ')' after function bodies.");
              }
            } else {
              throw Exception(
                  "parseEnvAsExtended; expected  'list' word before function bodies.");
            }
          } else {
            throw Exception(
                "parseEnvAsExtended; expected  '(' before function bodies.");
          }

          if (identifiers.length == bodies.length) {
            while (identifiers.isNotEmpty) {
              String id = identifiers.pop();
              String body = bodies.pop();

              stack.push(id);
              stack.push(body);
            }
          }
        } else if (word.toLowerCase() == "empty-env") {
          return stack;
        }
      } else {
        throw Exception(
            "Parsing Environment exception in parseEnvAsExtended; expected '(' after identifier");
      }
    }

    return stack;
  }

  EOPL_NODE.Node<String> parseASTString(EOPL_NODE.Node<String> node) {
    String nc = EOPL_IO.TextIO.getChar();
    if (nc == '(') {
      String word = EOPL_IO.TextIO.getWord();
      node.setData(word);

      nc = EOPL_IO.TextIO.getChar();
      while (nc != ')' && EOPL_IO.TextIO.moreInput()) {
        if (nc == '(') {
          EOPL_IO.TextIO.rewind(1);
          node.addChild(parseASTString(EOPL_NODE.Node<String>("")));
        } else if (nc == '\'') {
          EOPL_IO.TextIO.rewind(1);
          node.addChild(parseASTString(EOPL_NODE.Node<String>("")));
        } else if (nc == '-') {
          EOPL_IO.TextIO.rewind(1);
          node.addChild(parseASTString(EOPL_NODE.Node<String>("")));
        } else if (EOPL_IO.TextIO.isDigit(nc, 0)) {
          EOPL_IO.TextIO.rewind(1);
          node.addChild(parseASTString(EOPL_NODE.Node<String>("")));
        }

        nc = EOPL_IO.TextIO.getChar();
      }

      return node;
    } else if (nc == '\'') {
      String word = EOPL_IO.TextIO.getWord();
      node.setData(word);
      return node;
    } else if (nc == '-') {
      int number = -EOPL_IO.TextIO.getInt();
      node.setData(number.toString());
      return node;
    } else if (EOPL_IO.TextIO.isDigit(nc, 0)) {
      EOPL_IO.TextIO.rewind(1);
      int number = EOPL_IO.TextIO.getInt();

      node.setData(number.toString());
      return node;
    } else {}

    return EOPL_NODE.Node("");
  }

  void Update_Code(Type_Example typeExample) {
    try {
      currentLangDisplay =
          langNamesDisplay[langNamesDisplay.indexOf(typeExample.lang)];
      Code_Utils.instance.GL_SELECTED_LANG = currentLangDisplay;
      _ctrlCodeField!.text = typeExample.code;
      setState(() {
        isExamplesVisible = false;
      });

      EasyLoading.showSuccess("Current language is set as ${typeExample.lang}");
    } catch (ex) {
      EasyLoading.showError("This language does not exist in the memory!");
    }
  }

  int node_id = 0;

  void Set_AST(EOPL_NODE.Node node) {
    node_id = 0;
    var gNode = Node.Id(node.getData());

    var children = node.getChildren();

    for (var child in children) {
      var nodeTemp = child;
      var gNodeTemp = Node.Id(nodeTemp.getData() + "_" + node_id.toString());
      node_id++;

      Set_AST_Rec_Helper(gNodeTemp, nodeTemp);

      graph.addEdge(gNode, gNodeTemp);
    }
  }

  void Set_AST_Rec_Helper(Node mainNode, EOPL_NODE.Node eoNode) {
    var children = eoNode.getChildren();

    if (children.isNotEmpty) {
      for (var child in children) {
        var nodeTemp = child;
        var gNodeTemp = Node.Id(nodeTemp.getData() + "_" + node_id.toString());
        node_id++;

        Set_AST_Rec_Helper(gNodeTemp, nodeTemp);
        graph.addEdge(mainNode, gNodeTemp);
      }
    }
  }

  Widget rectangleWidget(String a) {
    return InkWell(
      onTap: () {},
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child: Text(a)),
    );
  }

  List<List<String>> prepareKeyValueArraysForEnv(int value) {
    List<String> keyList = List.empty(growable: true);
    List<String> valueList = List.empty(growable: true);

    List<List<String>> keyValuePairs =
        Code_Utils.instance.GL_ENV_LIST.elementAt(value);

    for (int i = 0; i < keyValuePairs.length; i++) {
      keyList.add(keyValuePairs.elementAt(i).elementAt(0));
      valueList.add(keyValuePairs.elementAt(i).elementAt(1));
    }

    List<List<String>> resultList = List.empty(growable: true);
    resultList.add(keyList);
    resultList.add(valueList);

    return resultList;
  }

  void Update_Slider(int val) {
    try {
      _ctrlCodeENVField.text =
          Code_Utils.instance.GL_EXP_LIST.elementAt(val).trim();

      List<List<String>> list = prepareKeyValueArraysForEnv(val);
      _ctrlENV.text = "";
      for (int i = 0; i < list.elementAt(0).length; i++) {
        _ctrlENV.text +=
            "${list.elementAt(0).elementAt(i)} -> ${list.elementAt(1).elementAt(i)}\n";
      }

      List<String> stoKeys =
          Code_Utils.instance.GL_STO_MAP_LIST.elementAt(val).keys.toList();
      List<String> stoVals =
          Code_Utils.instance.GL_STO_MAP_LIST.elementAt(val).values.toList();
      stoKeys = stoKeys.reversed.toList();
      stoVals = stoVals.reversed.toList();
      _ctrlStore.text = "";
      for (int i = 0; i < stoKeys.length; i++) {
        _ctrlStore.text +=
            "${stoKeys.elementAt(i)} -> ${stoVals.elementAt(i)}\n";
      }
    } catch (ex) {
      print(ex);
    }
  }

  Widget Screen_Component(double SH, double blueLineHeight, double SW) {
    if (screen_type == Screen_Types.SCREEN_TYPE_AST) {
      return Expanded(
        child: SizedBox(
          height: SH - blueLineHeight,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSettingsVisible = false;
                    isExamplesVisible = false;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InteractiveViewer(
                          constrained: false,
                          boundaryMargin: const EdgeInsets.all(100),
                          minScale: 0.01,
                          maxScale: 5.6,
                          child: GraphView(
                            graph: graph,
                            algorithm: BuchheimWalkerAlgorithm(
                                builder, TreeEdgeRenderer(builder)),
                            paint: Paint()
                              ..color = Colors.green
                              ..strokeWidth = 1
                              ..style = PaintingStyle.stroke,
                            builder: (Node node) {
                              // I can decide what widget should be shown here based on the id
                              var a = node.key!.value as String;
                              a = a.split("_")[0];
                              return rectangleWidget(a);
                            },
                          )),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isSettingsVisible,
                child: Container(
                  width: 700,
                  height: SH,
                  color: grayRGB040,
                  child: Setting_Panel(Update_Task: Update_Task),
                ),
              ),
              Visibility(
                visible: isExamplesVisible,
                child: Container(
                  width: SW * 0.3,
                  height: SH,
                  color: grayRGB040,
                  child: Examples(Update_Code: Update_Code),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (screen_type == Screen_Types.SCREEN_TYPE_ENV) {
      return Expanded(
        child: Container(
          color: grayRGB030,
          height: SH - blueLineHeight,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSettingsVisible = false;
                    isExamplesVisible = false;
                  });
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            width: 200,
                            height: 700,
                            color: grayRGB030,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: TextField(
                                readOnly: true,
                                focusNode: focus_node_env,
                                maxLines: null,
                                expands: true,
                                controller: _ctrlCodeENVField,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  labelText: "Current Expression",
                                  labelStyle: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                ),
                                cursorColor: white100,
                                style: tsTerminal,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            width: 200,
                            height: 700,
                            color: grayRGB030,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: TextField(
                                readOnly: true,
                                focusNode: focus_node_env,
                                maxLines: null,
                                expands: true,
                                controller: _ctrlENV,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  labelText: "Environment",
                                  labelStyle: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                ),
                                cursorColor: white100,
                                style: tsTerminal,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            width: 200,
                            height: 700,
                            color: grayRGB030,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: TextField(
                                focusNode: focus_node_store,
                                readOnly: true,
                                maxLines: null,
                                expands: true,
                                controller: _ctrlStore,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  labelText: "Store",
                                  labelStyle: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                ),
                                cursorColor: white100,
                                style: tsTerminal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 100,
                      decoration: BoxDecoration(
                          color: grayRGB140,
                          borderRadius: BorderRadius.circular(20)),
                      child: SfSlider(
                        shouldAlwaysShowTooltip: true,
                        min: 0,
                        activeColor: Colors.amber,
                        inactiveColor: Colors.blueAccent,
                        max: Code_Utils.instance.GL_EXP_LIST.length - 2,
                        value: _value,
                        interval: 1,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        minorTicksPerInterval: 1,
                        onChanged: (dynamic value) {
                          setState(() {
                            _value = double.parse(value.toString()).toInt();
                          });

                          Update_Slider(_value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
              Visibility(
                visible: isSettingsVisible,
                child: Container(
                  width: 700,
                  height: SH,
                  color: grayRGB040,
                  child: Setting_Panel(Update_Task: Update_Task),
                ),
              ),
              Visibility(
                visible: isExamplesVisible,
                child: Container(
                  width: SW * 0.3,
                  height: SH,
                  color: grayRGB040,
                  child: Examples(Update_Code: Update_Code),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: SizedBox(
        height: SH - blueLineHeight,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isSettingsVisible = false;
                  isExamplesVisible = false;
                });
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    color: grayRGB030,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Source",
                            style: tsTerminal,
                          ),
                          const Spacer(),
                          CupertinoButton(
                            onPressed: () {
                              Exec_Code();
                            },
                            pressedOpacity: 0.6,
                            padding: EdgeInsets.zero,
                            child: SvgPicture.asset(
                              "assets/icons/around/run.svg",
                              color: CupertinoColors.systemGreen,
                              width: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: Container(
                      width: double.infinity,
                      color: grayRGB020,
                      child: CodeField(
                        focusNode: focus_node_code,
                        expands: true,
                        controller: _ctrlCodeField!,
                        textStyle: const TextStyle(fontFamily: 'Roboto Mono'),
                        lineNumberStyle: const LineNumberStyle(
                          width: 80,
                          background: white005,
                          margin: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      width: double.infinity,
                      color: grayRGB030,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Output",
                              style: tsTerminal,
                            ),
                            const Spacer(),
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  _ctrlTerminal.clear();
                                });
                              },
                              pressedOpacity: 0.6,
                              padding: EdgeInsets.zero,
                              child: const Icon(
                                Icons.clear_all,
                                color: CupertinoColors.systemRed,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      width: double.infinity,
                      color: grayRGB030,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: TextField(
                          focusNode: focus_node_terminal,
                          readOnly: true,
                          maxLines: null,
                          expands: true,
                          controller: _ctrlTerminal,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          cursorColor: white100,
                          style: tsTerminal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isSettingsVisible,
              child: Container(
                width: 700,
                height: SH,
                color: grayRGB040,
                child: Setting_Panel(Update_Task: Update_Task),
              ),
            ),
            Visibility(
              visible: isExamplesVisible,
              child: Container(
                width: SW * 0.3,
                height: SH,
                color: grayRGB040,
                child: Examples(Update_Code: Update_Code),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double SW = MediaQuery.of(context).size.width;
    double SH = MediaQuery.of(context).size.height;
    double blueLineHeight = 26;
    double blueLineIconHeight = blueLineHeight - 6;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: SW,
        height: SH,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: SH - blueLineHeight,
                  color: grayRGB060,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: CupertinoButton(
                            onPressed: () {
                              setState(() {
                                screen_type =
                                    Screen_Types.SCREEN_TYPE_CODE_EDITOR;
                              });
                            },
                            pressedOpacity: 0.6,
                            padding: EdgeInsets.zero,
                            child: const Icon(Icons.code),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: CupertinoButton(
                            onPressed: () {
                              setState(() {
                                if (isSettingsVisible == true) {
                                  isSettingsVisible = false;
                                } else {
                                  isSettingsVisible = true;
                                  isExamplesVisible = false;
                                }
                              });
                            },
                            pressedOpacity: 0.6,
                            padding: EdgeInsets.zero,
                            child: const Icon(Icons.settings),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: CupertinoButton(
                          onPressed: () {
                            setState(() {
                              if (isExamplesVisible == true) {
                                isExamplesVisible = false;
                              } else {
                                isExamplesVisible = true;
                                isSettingsVisible = false;
                              }
                            });
                          },
                          pressedOpacity: 0.6,
                          padding: EdgeInsets.zero,
                          child: const Icon(Icons.source),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: CupertinoButton(
                          onPressed: () {
                            if (Code_Utils.instance.GL_EXP_LIST.isNotEmpty) {
                              setState(() {
                                screen_type = Screen_Types.SCREEN_TYPE_AST;
                              });
                            } else {
                              EasyLoading.showInfo("There is no data for AST");
                            }
                          },
                          pressedOpacity: 0.6,
                          padding: EdgeInsets.zero,
                          child: const Icon(CupertinoIcons.graph_circle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: CupertinoButton(
                          onPressed: () {
                            if (Code_Utils.instance.GL_ENV_LIST.isNotEmpty) {
                              setState(() {
                                screen_type = Screen_Types.SCREEN_TYPE_ENV;
                              });
                            } else {
                              EasyLoading.showInfo("There is no data for ENV");
                            }
                          },
                          pressedOpacity: 0.6,
                          padding: EdgeInsets.zero,
                          child: const Icon(Icons.analytics),
                        ),
                      ),
                    ],
                  ),
                ),
                Screen_Component(SH, blueLineHeight, SW)
              ],
            ),
            StatusBar(
              langText: currentLangDisplay,
              onLangPressed: () {
                setState(() {
                  indexLang += 1;
                  if (indexLang == langNamesDisplay.length) {
                    indexLang = 0;
                  }

                  currentLangDisplay = langNamesDisplay[indexLang];
                });
                Code_Utils.instance.GL_SELECTED_LANG = currentLangDisplay;
              },
            ),
          ],
        ),
      ),
    );
  }
}
