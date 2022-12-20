import 'UserData.dart';
import 'dart:math';

List<UserData> randomize(List<UserData> participants) {
  //Remove items from the list if the name or email has not been entered
  participants.removeWhere((element) =>
      element.name.toString().trim() == "" ||
      element.email.toString().trim() == "");

  List<UserData> tempList = participants;
  List<UserData> randomizedList = []; //List to hold the participants
  Random randomizer = Random(DateTime.now()
      .microsecondsSinceEpoch); //Randomizes based on current time in milliseconds

  //While the participants list is not empty, get a random number to select the giftee
  while (tempList.length > 0) {
    //Get the random number
    int randomNum = randomizer.nextInt(participants.length);

    randomizedList.add(tempList[randomNum]);
    tempList.removeAt(randomNum);
  } //end for

  print('first list');
  for (int i = 0; i < participants.length; i++) {
    print('item $i: ${participants[i].toString()}');
  } //end for

  print('random list');
  for (int i = 0; i < randomizedList.length; i++) {
    print('item $i: ${randomizedList[i].toString()}');
  } //end for

  return randomizedList;
}
