import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double kgToPounds(double kg) => kg * 2.205;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(KilogramConverter());
}

class KilogramConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Kilograms to Pounds Converter',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: MyHomePage(title: 'Kilograms to Pounds Converter'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const textFieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.orange),
  );

  double _pounds = 0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.grey[800],
            Colors.grey[700],
            Colors.grey[600],
            Colors.grey[500],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.grey[800]),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange[800],
                  Colors.orange[700],
                  Colors.orange[600],
                  Colors.orange[500],
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final fontStyle = TextStyle(
                fontSize: constraints.maxWidth * .10,
                color: Colors.orange,
              );

              return Container(
                padding: EdgeInsets.only(top: constraints.maxHeight * .15),
                width: constraints.maxWidth * .5,
                child: Column(
                  children: <Widget>[
                    TextField(
                      cursorColor: Colors.orange,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: fontStyle,
                      decoration: InputDecoration(
                        enabledBorder: textFieldBorder,
                        focusedBorder: textFieldBorder,
                        suffixText: 'kg',
                        suffixStyle: fontStyle,
                        hintText: 'Kilograms',
                        hintStyle: TextStyle(
                            color: Colors.white30,
                            fontSize: constraints.maxWidth * .09),
                      ),
                      onChanged: (String text) {
                        final kg = double.tryParse(text);

                        setState(() {
                          _pounds = kg != null ? kgToPounds(kg) : 0;
                        });
                      },
                    ),
                    SizedBox(
                      height: constraints.maxHeight * .15,
                    ),
                    Text(
                      'Pounds',
                      style: fontStyle,
                    ),
                    Text(
                      _pounds.toStringAsFixed(2),
                      style: fontStyle,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
