import 'package:flutter/material.dart';

class ComboBox extends StatefulWidget {
  final String label;
  final List<String> options;
  int select;

  ComboBox({this.select = 0,
    Key? key,
    required this.label,
    required this.options    
  }) : super(key: key);

  @override
  State<ComboBox> createState() => _ComboBoxWidgetState();
}

class _ComboBoxWidgetState extends State<ComboBox> {
  String selectedValue = '-';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 280,
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(widget.label)),
                isExpanded: true,
                onChanged: (newValue) {
                  setState(() {
                    widget.select = newValue!;
                  });
                },
                items: List.generate(widget.options.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(widget.options[index]),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
