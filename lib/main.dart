import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eopl_ide/screens/Main_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CodeEditorHome());
}

class CodeEditorHome extends StatefulWidget {
  const CodeEditorHome({Key? key}) : super(key: key);

  @override
  State<CodeEditorHome> createState() => _CodeEditorHomeState();
}

class _CodeEditorHomeState extends State<CodeEditorHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: "EOPL IDE",
      debugShowCheckedModeBanner: false,
      home: const CodeEditorMainScreen(),
    );
  }
}
