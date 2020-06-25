import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chips Input',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ChipsInputState> _chipKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chips Input Example'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                minLines: 3,
                maxLines: 1000,
              ),
              Padding(padding: const EdgeInsets.only(top: 30.0)),
              ChipsInput<String>(
                key: _chipKey,
                initialValue: [],
                // autofocus: true,
                // allowChipEditing: true,
                keyboardAppearance: Brightness.dark,
                inputAction: TextInputAction.done,
//                inputType: TextInputType.emailAddress,
                enabled: true,
//                maxChips: 5,
                textStyle: TextStyle(height: 1.5, fontFamily: "Roboto", fontSize: 16),
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.search),
                  // hintText: formControl.hint,
                  labelText: "Select People",
                  // enabled: false,
                  // errorText: field.errorText,
                ),
                findSuggestions: (String query) {
                  return [];
                },
                onChanged: (data) {},
                onTextChanged: (text) {
                  if (text?.contains(',') == true && text.trim().length > 1) {
                    _chipKey.currentState?.selectSuggestion(text.replaceAll(',', ''));
                  }
                },
                onSubmit: (TextInputAction action) {
                  String _text = _chipKey.currentState?.text?.replaceAll(',', '');
                  debugPrint('onSubmit: $_text');
                  if (_text?.isNotEmpty == true && _text.trim().length > 1) {
                    _chipKey.currentState?.selectSuggestion(_text.replaceAll(',', ''));
                  }
                },
                chipBuilder: (context, state, profile) {
                  return InputChip(
                    key: ObjectKey(profile),
                    label: Text(profile),
                    onDeleted: () => state.deleteChip(profile),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (context, state, profile) {
                  return ListTile(
                    key: ObjectKey(profile),
                    title: Text(profile),
                    onTap: () => state.selectSuggestion(profile),
                  );
                },
              ),
              RaisedButton(
                child: Text('Add Chip'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
