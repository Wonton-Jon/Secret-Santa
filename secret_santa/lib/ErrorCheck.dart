import 'dart:math';

enum ERROR_CODE { VALID, EMPTY_TEXT, INVALID_INT, OUT_OF_BOUNDS }

final MIN_PARTICIPANTS = 3;
final MAX_PARTICIPANTS = pow(10, 5).toInt();

//Attempt to parse string as int
//Throw exception and print error message if the string is not int formatted
ERROR_CODE checkInt(String value) {
  ERROR_CODE errorCode = ERROR_CODE.VALID; //Set error code to valid status
  try {
    int val = int.parse(value);
  } on FormatException catch (error) {
    errorCode = ERROR_CODE.INVALID_INT;
    return errorCode;
  } //end catch

  //Set the number of participants
  int numParticipants = int.parse(value);

  //Check the bounds of the value
  if (!checkBounds(numParticipants, MIN_PARTICIPANTS, MAX_PARTICIPANTS))
    errorCode = ERROR_CODE.OUT_OF_BOUNDS;

  //If the string is empty, set error code
  if (value.trim().length == 0) errorCode = ERROR_CODE.EMPTY_TEXT;

  print("errorCode = ${errorCode.toString()}");

  //Return the correct widget
  return errorCode;
}

//Return true if the value is between the min and max inclusive
bool checkBounds(int value, int MIN, int MAX) {
  return MIN <= value && value <= MAX;
}

//Returns error message based on error code passed in
getErrorMessage(ERROR_CODE error) {
  String errorMessage = ""; //Error message to be printed

  print('inside getErrorMessage() errorcode = ${error.toString()}');

  switch (error) {
    case ERROR_CODE.EMPTY_TEXT:
      errorMessage = "Please enter a number.";
      break;
    case ERROR_CODE.INVALID_INT:
      errorMessage = "Number of participants must be an integer.";
      break;
    case ERROR_CODE.OUT_OF_BOUNDS:
      errorMessage = "Number of participants must be between $MIN_PARTICIPANTS and $MAX_PARTICIPANTS.";
      break;
    case ERROR_CODE.VALID:
      errorMessage = "";
      break;
  } //end switch

  return errorMessage;
}
