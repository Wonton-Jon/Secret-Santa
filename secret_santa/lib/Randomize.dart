import 'UserData.dart';
import 'dart:math';

//WIll randomize the participants into a list
List<UserData> randomize(List<UserData> participants) {
  //Remove items from the list if the name or email has not been entered
  participants.removeWhere((element) =>
      element.name.toString().trim() == "" ||
      element.email.toString().trim() == "");

  List<UserData> tempList = participants.toList();
  List<UserData> randomizedList = []; //List to hold the participants
  Random randomizer = Random(DateTime.now()
      .microsecondsSinceEpoch); //Randomizes based on current time in milliseconds

  //While the participants list is not empty, get a random number to select the giftee
  while (tempList.length > 0) {
    //Get the random number
    int randomNum = randomizer.nextInt(tempList.length);

    randomizedList.add(tempList[randomNum]);
    tempList.removeAt(randomNum);
  } //end for

  return randomizedList;
}

//Assigns the participants to the person listed after them.
//Ex: participant[0] is assigned participant[1], etc.
//participant[participants.length - 1] is assigned participant[0] i.e. the last person
//in the list is assigned the first person
List<UserData> assignSecretSantas(List<UserData> participants) {
  
  try {
    for (int i = 0; i < participants.length - 1; i++) {
      participants[i].assignee = participants[i + 1];
    } //end for
    participants[participants.length - 1].assignee = participants[0];
    
    for (int i = 0; i < participants.length; i++) {
      print('item $i: ${participants[i].toString()}');
    } //end for
  } on Exception catch (e) {
    
  }
  

  return participants;
}
