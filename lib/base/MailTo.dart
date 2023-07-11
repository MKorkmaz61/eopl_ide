import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
  static void call(String number) => launch("tel://$number");

  static void sendSms(String number) => launch("sms:$number");

  static void sendEmail(String email) => launch("mailto:$email");
}

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}