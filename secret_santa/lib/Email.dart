import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'UserData.dart';

//Creates list of emails to send to each person and sends them
Future composeAndSendEmails(List<UserData> participants) async {
  for (int i = 0; i < participants.length; i++) {
    //Used for testing
    Email e = Email(
      body: 'Hello there ${participants[i].name}!\n'
          'You have been given the role of being ${participants[i].assignee!.name.toString()}\'s Secret Santa !!!',
      subject: 'Secret Santaaaaaa',
      recipients: [participants[i].email.toString()],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    print('$i--------------------------------------');
    print('santa: ${participants[i].name}');
    print('santa email: ${participants[i].email}');
    print('assignee: ${participants[i].assignee!.name}');
    print('assignee email: ${participants[i].assignee!.email}');

    //end testing

    // await FlutterEmailSender.send(Email(
    //   body: 'Hello there ${participants[i].name}!\n'
    //       'You have been given the role of being ${participants[i].assignee!.name.toString()}\'s Secret Santa !!!',
    //   subject: 'Secret Santaaaaaa',
    //   recipients: [participants[i].email.toString()],
    //   cc: [],
    //   bcc: [],
    //   attachmentPaths: [],
    //   isHTML: false,
    // ));
  } //end for
}
