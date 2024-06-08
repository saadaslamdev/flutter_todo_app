import 'package:flutter/material.dart';

class AddText extends StatefulWidget {
  void Function(String text) onAddNote;
  AddText({super.key, required this.onAddNote});

  @override
  State<AddText> createState() => _AddTextState();
}

class _AddTextState extends State<AddText> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Column(children: [
      TextField(
        controller: _textEditingController,
        decoration: const InputDecoration(
          labelText: 'Add a Todo',
        ),
      ),
      SizedBox(height: screenSize.height * 0.02),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: _textEditingController.text.isNotEmpty
            ? () {
                widget.onAddNote(_textEditingController.text);
                Navigator.of(context).pop();
              }
            : null,
        child: Text('Add', style: TextStyle(color: Colors.white, fontSize: screenSize.width * 0.048)),
      )
    ]);
  }
}
