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
              ChipsInput<String>(
                key: _chipKey,
                initialValue: [],
                // autofocus: true,
                // allowChipEditing: true,
                keyboardAppearance: Brightness.dark,
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
                onChanged: (data) {
                  // print(data);
                },
                onTextChanged: (text) {
                  debugPrint('Text: $text');
                  if (text?.contains(',') == true && text.trim().length > 1) {
                    _chipKey.currentState?.selectSuggestion(text.replaceAll(',', ''));
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
