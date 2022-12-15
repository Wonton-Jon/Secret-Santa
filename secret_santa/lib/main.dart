import 'package:flutter/material.dart';
import 'package:secret_santa/ErrorCheck.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Santaaaaa',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Secwet Santwa ^u^'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ERROR_CODES errorCode = ERROR_CODES.VALID;
  final _participantCountController = TextEditingController();
  String? numParticipants = "";

  Future errorCheck(numParticipants) async {
    setState(() {
      numParticipants = _participantCountController.text.trim();
      errorCode = checkInt(numParticipants);
    });
  }

  @override
  Widget build(BuildContext context) {
    String numParticipants = ""; //Number of participants to be parsed

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _participantCountController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Number of Participants',
                ),
                onFieldSubmitted: (numParticipants) {
                  int participants = 0;

                  //If the error code is valid, then parse it
                  if (errorCode == ERROR_CODES.VALID)
                    participants = int.parse(numParticipants);

                  print('participants = $participants');
                  print('errormessage = ${getErrorMessage(errorCode)}');

              
                },
                onEditingComplete: () {
                  errorCheck(numParticipants);
                },
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                child: Text(
                  getErrorMessage(errorCode),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                )),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: errorCheck(numParticipants),
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Container newUserField() {
  return Container(
    child: Column(children: [
      TextField(
        onChanged: (value) {
          print('vlaue is $value');
        },
        decoration: InputDecoration(
          hintText: 'Enter person\'s name.',
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
      TextField(
        onChanged: (value) {
          print('vlaue is $value');
        },
        decoration: InputDecoration(
          hintText: 'Enter person\'s email address.',
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    ]),
  );
}

printErrorMessage(errorCode) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
    child: getErrorMessage(errorCode),
  );
}
