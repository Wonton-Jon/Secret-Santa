import 'UserData.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'GoogleAuthApi.dart';

Future<int> composeAndSendEmails(List<UserData> participants) async {
  print('inside composeAndSendEmails()');
  int amountSent = 0;
  for (int i = 0; i < participants.length; i++) {
    if (await sendEmail(
        participants[i].email,
        'Hello there ${participants[i].name}!\n'
        'You have been given the role of being ${participants[i].assignee!.name.toString()}\'s Secret Santa !!!'))
      amountSent++;
  } //end for

  return await amountSent;
}

Future<bool> sendEmail(String? recipient, String? messageBody) async {
  final user = await GoogleAuthApi.signIn();
  bool sent = false;
  print('user $user');
  if (user == null) return sent;

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
    sent = true;
  } on Exception catch (e) {
    print("Error email to $recipient failed");
    print(e);
    sent = false;
  }

  return await sent;
}
