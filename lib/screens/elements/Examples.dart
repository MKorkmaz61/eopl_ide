import 'package:eopl_ide/Code_Examples.dart';
import 'package:eopl_ide/base/Colors.dart';
import 'package:eopl_ide/base/TextStyles.dart';
import 'package:flutter/material.dart';

class Examples extends StatefulWidget {
  final Function(Type_Example) Update_Code;
  const Examples({super.key, required this.Update_Code});

  @override
  State<Examples> createState() => _ExamplesState();
}

class _ExamplesState extends State<Examples> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      const Center(
        child: Text(
          "Examples",
          style: TextStyle(color: Colors.white),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      for (int i = 0; i < Code_Examples.example_dict.length; i++) ...[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: 50,
            color: grayRGB030,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () {
                  super.widget.Update_Code(
                      Code_Examples.example_dict.values.elementAt(i));
                },
                child: TextFormField(
                  initialValue: Code_Examples.example_dict.keys
                      .elementAt(i)
                      .replaceAll("_", " "),
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  cursorColor: white100,
                  style: tsPath,
                ),
              ),
            ),
          ),
        ),
      ]
    ]);
  }
}
