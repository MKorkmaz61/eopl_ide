import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:eopl_ide/base/Colors.dart';
import 'package:eopl_ide/base/TextStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting_Panel extends StatefulWidget {
  final Function Update_Task;
  const Setting_Panel({super.key, required this.Update_Task});

  @override
  State<Setting_Panel> createState() => _Setting_PanelState();
}

class _Setting_PanelState extends State<Setting_Panel> {
  TextEditingController ctrl_racket_path = TextEditingController();
  TextEditingController ctrl_language_dir = TextEditingController();

  @override
  void initState() {
    ctrl_racket_path.text = "Racket Exec Path";
    ctrl_language_dir.text = "Directory of Languages";
    Future.delayed(Duration.zero, Get_File_Paths_From_Memory);
  }

  Future<void> Get_File_Paths_From_Memory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? racketPath = prefs.getString('eopl_racket_ex_file_path');
    if (racketPath != null) {
      ctrl_racket_path.text = racketPath;
    }

    String? langDir = prefs.getString('eopl_languages_dir');
    if (langDir != null) {
      ctrl_language_dir.text = langDir;
    }
  }

  void Get_Racket_Exec_Path() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var filePath = result.files.single.path;
      ctrl_racket_path.text = filePath!;

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('eopl_racket_ex_file_path', filePath);

      super.widget.Update_Task.call();
    }
  }

  void Get_Lang_Dir_Path() async {
    var result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      var dirPath = result;
      ctrl_language_dir.text = dirPath;

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('eopl_languages_dir', dirPath);
      super.widget.Update_Task.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Center(
        child: Text(
          "Settings",
          style: tsPath,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 50,
          color: grayRGB030,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ),
            child: InkWell(
              onTap: () {
                Get_Racket_Exec_Path();
              },
              child: TextField(
                controller: ctrl_racket_path,
                enabled: false,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: "Racket Exec Path"),
                cursorColor: white100,
                style: tsPath,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 50,
          color: grayRGB030,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ),
            child: InkWell(
              onTap: () {
                Get_Lang_Dir_Path();
              },
              child: TextField(
                controller: ctrl_language_dir,
                enabled: false,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: "Directory of Languages"),
                cursorColor: white100,
                style: tsPath,
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
