import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'UserData.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'GoogleAuthApi.dart';

//Creates list of emails to send to each person and sends them
Future composeEmails(List<UserData> participants) async {
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

    await FlutterEmailSender.send(Email(
      body: 'Hello there ${participants[i].name}!\n'
          'You have been given the role of being ${participants[i].assignee!.name.toString()}\'s Secret Santa !!!',
      subject: 'Secret Santaaaaaa',
      recipients: [participants[i].email.toString()],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    ));
  } //end for

  '''
  jmaguirre111@gmail.com
  jomaguir@ucsc.edu
  thechowshims456@gmail.com
  Megalodon6e23@gmail.com

  ''';
}

Future composeAndSendEmails(List<UserData> participants) async {
  print('inside composeAndSendEmails()');
  for (int i = 0; i < participants.length; i++) {
    await sendEmail(
        participants[i].name,
        'Hello there ${participants[i].name}!\n'
        'You have been given the role of being ${participants[i].assignee!.name.toString()}\'s Secret Santa !!!');
  } //end for
}

Future sendEmail(String? recipient, String? messageBody) async {
  final user = await GoogleAuthApi.signIn();
  print('user $user');
  if (user == null) return;

  String email = user.email.trim();
  final auth = await user.authentication;
  final token = auth.accessToken;

  print(
      '---------------------------------------------------------------------');
  print('email: $email');
  print('recipients: $recipient');
  print('text: $messageBody');
  print(
      '---------------------------------------------------------------------');

  final smtpServer = gmailSaslXoauth2(email, token.toString());
  Message message = Message()
    ..from = Address(email, 'Wonton')
    ..recipients = [recipient]
    ..subject = 'Secret Santaaa'
    ..text = messageBody.toString();

  try {
    await send(message, smtpServer);
  } on Exception catch (e) {
    print("Error email to $recipient failed");
    print(e);
  }
}
