import 'package:url_launcher/url_launcher.dart';

goToWebPage() async {
  String urlString = 'https://help.proofhub.com/plus/others/login-2/';
  final Uri _url = Uri.parse(urlString);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
