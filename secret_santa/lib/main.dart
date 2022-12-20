import 'package:flutter/material.dart';
import 'package:secret_santa/ErrorCheck.dart';
import 'package:secret_santa/Randomize.dart';
import 'UserData.dart';

List<UserData> participantContainers = [];

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

  //Return the error code of the error checked values
  Future<ERROR_CODE> errorCheck() async {
    setState(() {
      //Get the number of participants and error check the value entered
      numParticipants = _participantCountController.text.trim();
      errorCode = checkInt(numParticipants.toString());
    });

    //If the value entered is valid, then parse and initialize the list of participants
    if (errorCode == ERROR_CODE.VALID) {
      createNewParticipantList();
    } //end if

    return errorCode;
  }

  void createNewParticipantList() {
    numParticipants = _participantCountController.text.trim();
    participants = int.parse(numParticipants.toString());

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
                  //============================================================
                  // When the value in the Textfield is changed, create the list
                  // of participant data fields
                  //============================================================
                  onChanged: (numParticipants) {
                    //Get the number of participants
                    numParticipants = _participantCountController.text.trim();

                    //Error check the value
                    setState(() {
                      //Get the number of participants and error check the value entered
                      errorCode = checkInt(numParticipants.toString());
                    });
                    //If the status code returns a valid value, then get the number entered
                    if (errorCode == ERROR_CODE.VALID) {
                      participants = int.parse(numParticipants.toString());
                      createNewParticipantList();
                    } //end if
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
              //If the number of participants is zero, create an empty container,
              //Otherwise create the list of data
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
            ],
          ),
        ),
      ),
      //========================================================================
      // Placement for the increment and decrement buttons
      //========================================================================
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //==================================================================
            // Button will increment the number of participants entered
            //==================================================================
            FloatingActionButton(
              child: new Icon(Icons.add),
              focusColor: Colors.green[900],
              heroTag: 'IncrementButton',
              onPressed: () {
                //Set the state of the values to reload the widgets
                setState(() {
                  //Get the number of participants and error check the value entered
                  numParticipants = _participantCountController.text.trim();
                  errorCode = checkInt(numParticipants.toString());
                });

                //If the errorcode shows the value entered is valid,
                //Then get the number of participants and increment it
                //Create the list of participants
                if (errorCode == ERROR_CODE.VALID) {
                  participants = int.parse(numParticipants.toString());
                  participants++;
                  _participantCountController.text = participants.toString();
                  createNewParticipantList();
                } //end if
              },
            ),

            Expanded(child: Container()),

            //==================================================================
            // Button will assign secret santas to valid participants
            //==================================================================
            FloatingActionButton(
              child: new Icon(Icons.check),
              focusColor: Colors.green[900],
              heroTag: 'RandomizeButton',
              onPressed: () {
                print("randomize button pressed");
                //Set the state of the values to reload the widgets
                errorCode = checkInt(_participantCountController.text.trim());

                //If the errorcode shows the value entered is valid,
                //Then get the number of participants and increment it
                //Create the list of participants
                if (errorCode == ERROR_CODE.VALID) {
                  randomize(participantContainers);
                } //end if
              },
            ),

            Expanded(child: Container()),

            //==================================================================
            // Button will decrement the number of participants entered
            //==================================================================
            FloatingActionButton(
              child: new Icon(Icons.remove),
              focusColor: Colors.green[900],
              heroTag: 'DecrementButton',
              onPressed: () {
                //Set the state of the values to reload the widgets
                setState(() {
                  //Get the number of participants and error check the value entered
                  numParticipants = _participantCountController.text.trim();
                  errorCode = checkInt(numParticipants.toString());
                }); //If the error code is valid, then increment the number of participants

                //If the errorcode shows the value entered is valid,
                //Then get the number of participants and decrement it
                //Create the list of participants
                if (int.tryParse(numParticipants.toString()) != null) {
                  participants = int.parse(numParticipants.toString());
                  participants--;
                  _participantCountController.text = participants.toString();
                  createNewParticipantList();
                } //end if
              },
            )
          ],
        ),
      ),
    );
  }
}
