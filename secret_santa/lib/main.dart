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
  List<UserData> participantContainers = [];

  //Return the error code of the error checked values
  Future<ERROR_CODE> errorCheck(numParticipants) async {
    setState(() {
      //Get the number of participants and error check the value entered
      numParticipants = _participantCountController.text.trim();
      errorCode = checkInt(numParticipants);
    });

    //If the value entered is valid, then parse and initialize the list of participants
    if (errorCode == ERROR_CODE.VALID) {
      participants = int.parse(numParticipants);

      //Creaete a temporary list to hold the original values so that when the list size changes, the older values are still persistent
      List<UserData> tempList = participantContainers;

      //Clear the list to reset the list size
      participantContainers = [];

      //Load the list of older values into the list of new values

      for (int i = 0; i < tempList.length && i < participants; i++) {
        participantContainers.add(tempList[i]);
      } //end for

      int unadded = participants -
          tempList.length; //Number of users that need to be added to list

      //Add new users to list if the list size is less than the number specified
      for (int i = 0;
          i < unadded && participantContainers.length < participants;
          i++) {
        UserData newUser = UserData(name: "", email: "");
        participantContainers.add(newUser);
      } //end for
    } //end if

    return errorCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 30),
        ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _participantCountController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Number of Participants',
                  ),
                  onFieldSubmitted: (numParticipants) {
                    print('start onFieldSubmitted()');

                    //If the error code is valid, then parse it
                    if (errorCode == ERROR_CODE.VALID) {
                      participants = int.parse(numParticipants);
                    } //end if

                    print('participants = $participants');
                    print('errormessage = ${getErrorMessage(errorCode)}');
                    print('end onFieldSubmitted()');
                  },
                  onEditingComplete: () {
                    print('start onEditingComplete()');
                    //Clear the list view before creating a new one

                    numParticipants = _participantCountController.text.trim();
                    errorCheck(numParticipants);

                    //If the error code is valid, then parse it
                    if (errorCode == ERROR_CODE.VALID)
                      participants = int.parse(numParticipants.toString());

                    //If the error checking is successful, then display user data containers
                    //equal to the number of users entered
                    print('end onEditingComplete()');
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 0.0),
                  child: Text(
                    getErrorMessage(errorCode),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  )),
              participants == 0
                  ? Container()
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: participantContainers.length,
                      itemBuilder: (context, index) {
                        return participantContainers[index].getContainer();
                      },
                      shrinkWrap: true,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    child: new Icon(Icons.add),
                    focusColor: Colors.green[900],
                    heroTag: 'IncrementButton',
                    onPressed: () {
                      //If the error code is valid, then increment the number of participants
                      print('increment pressed');
                      numParticipants = _participantCountController.text.trim();
                      if (int.tryParse(numParticipants.toString()) != null) {
                        participants = int.parse(numParticipants.toString());
                        participants++;
                        _participantCountController.text =
                            participants.toString();
                      } //end if
                    },
                  ),
                  FloatingActionButton(
                    child: new Icon(Icons.remove),
                    focusColor: Colors.green[900],
                    heroTag: 'DecrementButton',
                    onPressed: () {
                      print('decrement pressed');
                      numParticipants = _participantCountController.text.trim();
                      //If the error code is valid, then increment the number of participants
                      if (int.tryParse(numParticipants.toString()) != null) {
                        participants = int.parse(numParticipants.toString());
                        participants--;
                        _participantCountController.text =
                            participants.toString();
                      } //end if
                    },
                  )
                ],
              )
              // separatorBuilder: (BuildContext context, int index) =>
              //     Divider(
              //   height: 8,
              //   thickness: 1,
              //   color: Colors.transparent,
              //   endIndent: 10,
              //   indent: 10,
              // ),
              , //Put floating action button to add user underneath the last item in the list view
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
