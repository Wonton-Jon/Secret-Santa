import 'package:flutter/material.dart';
import 'package:secret_santa/ErrorCheck.dart';
import 'UserData.dart';

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
      home: const MyHomePage(title: 'Secwet Santwa ^u^ :D'),
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
  ERROR_CODE errorCode = ERROR_CODE.VALID;
  final _participantCountController = TextEditingController();
  String? numParticipants = "";
  int participants = 0;
  List<UserData> particpantContainers = [];

  //Return the error code of the error checked values
  Future<ERROR_CODE> errorCheck(numParticipants) async {
    setState(() {
      numParticipants = _participantCountController.text.trim();
      errorCode = checkInt(numParticipants);
    });

    if (errorCode == ERROR_CODE.VALID) {
      participants = int.parse(numParticipants);
      for (int i = 0; i < participants; i++) {
        UserData newUser = UserData(name: "", email: "");
        particpantContainers.add(newUser);
      }//end for
    } //end if

    return errorCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
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
                    //If the error code is valid, then parse it
                    if (errorCode == ERROR_CODE.VALID)
                      participants = int.parse(numParticipants);
      
                    print('participants = $participants');
                    print('errormessage = ${getErrorMessage(errorCode)}');
                  },
                  onEditingComplete: () {
                    //If the error checking is successful, then display user data containers
                    //equal to the number of users entered
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
              participants == 0
                  ? Container()
                  : ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: particpantContainers.length,
                      itemBuilder: (context, index) {
                        return particpantContainers[index].getContainer();
                      },
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 8,
                        thickness: 1,
                        color: Colors.transparent,
                        endIndent: 10,
                        indent: 10,
                      ),
                    ), //Put floating action button to add user underneath the last item in the list view
            ],
          ),
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
