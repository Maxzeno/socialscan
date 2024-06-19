import 'package:flutter/material.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/url.dart';

String createAnAccount = 'Create\nan Account';
String email = 'Email';
String password = 'Password';
String reTypePassword = 'Re-type Password';
String forgotPassword = 'Forgot password?';
String alreadyHaveAnAccount = 'Already have an account?';
String login = 'Login';
String create = 'Create';
String signUp = 'Sign up';
String google = 'Google';
String faceBook = 'FaceBook';
String instagram = 'Instagram';
String whatsApp = 'Whatsapp';
String twitter = 'X';
String linkedin = 'LinkedIn';
String orContinueWith = 'or continue with';
String dontHaveAnAccount = 'Don\'t have an account?';
String helloWelcomeBack = 'Hello,\nWelcome Back';
String settings = 'Settings';
String name = 'Name';
String mySocials = 'My socials';
String profession = 'Profession';
String phone = 'Phone';
String addNew = 'Add New';
String connect = 'Connect';
String scan = 'Scan';
String general = 'General';
String profile = 'Profile';
String changePassword = 'Change Password';
String theme = 'Theme';
String addNewSocial = 'Add New Social';
String whileConnecting = 'While Connecting';
String sharePhoneNumber = 'Share phone number';
String shareEmail = 'Share email';
String davidRay = 'David Ray';
String helloDavid = 'Hello David';
String profileEmail = 'davidray@gmail.com';
String profileImage =
    'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.1700460183.1708041600&semt=ais';
String profileImage2 =
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww';
String profileImage3 =
    'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cGVyc29ufGVufDB8fDB8fHww';
String save = 'Save';
String fullStack = 'Full-stack Engineer';
String enterCurrentPassword = 'Enter Current Password';
String enterNewPassword = 'Enter new password';
String reEnterPassword = 'Re-enter password';
String helloTest = 'Hello Test';
String home = 'Home';
String network = 'Network';
String today = 'Today';
String yesterday = 'Yesterday';
String month = 'January 16';

///testing lists ...

// List<SocialLinkModel> selectedItems = [];
// final List<SocialLinkModel> socialLinks = [];

UserModel parseQRData(String qrData) {
  qrData = parseQrUrl(qrData);
  print("Scanned QR Data: $qrData");
  List<String> userData = qrData.split(';');
  print('Users ===> $userData');
  if (userData.length < 5) {
    throw Exception('Invalid QR data format');
  }
  String fullName = userData[0];
  // String lastName = userData[1];
  String phoneNumber = userData[1];
  String profession = userData[2];
  String email = userData[3];
  String id = userData[4];
  String image = '';
  List<SocialLinkModel> socialLinks = [];

  if (userData.length > 5) {
    if (userData[5].startsWith('https')) {
      image = userData[5];
    } else {
      socialLinks = parseSocialLinks(userData[5]);
    }
  }

  if (userData.length > 6) {
    socialLinks = parseSocialLinks(userData[6]);
  }

  return UserModel(
    id: id,
    fullName: fullName,
    // lastName: lastName,
    phoneNumber: phoneNumber,
    profession: profession,
    email: email,
    image: image,
    socialMediaLink: socialLinks,
  );
}

List<SocialLinkModel> parseSocialLinks(String socialLinksString) {
  List<String> linksData = socialLinksString.split(',');
  List<SocialLinkModel> socialLinks = [];
  for (int i = 0; i < linksData.length; i += 5) {
    if (i + 5 > linksData.length) {
      throw Exception('Invalid social link data format');
    }
    String text = linksData[i];
    String imagePath = linksData[i + 1];
    String conColorHex = linksData[i + 2];
    String iconColorHex = linksData[i + 3];
    String linkUrl = linksData[i + 4];
    socialLinks.add(SocialLinkModel(
      text: text,
      imagePath: imagePath,
      conColor: parseColor(conColorHex),
      iconColor: parseColor(iconColorHex),
      // conColor: Color(int.parse(conColorHex.substring(1), radix: 16)),
      // iconColor: Color(int.parse(iconColorHex.substring(1), radix: 16)),
      linkUrl: linkUrl,
    ));
  }
  print('Social add ===> $socialLinks');
  return socialLinks;
}

Color parseColor(String colorString) {
  String hexCode = colorString.split('(')[1].split(')')[0].substring(2);

  if (hexCode.isNotEmpty && hexCode.length == 8) {
    int hexValue = int.parse(hexCode, radix: 16);
    return Color(hexValue);
  }
  return Colors.black;
}

/// time

String formatTimestampToDay(DateTime timestamp) {
  final today = DateTime.now();
  final daysDifference = today.difference(timestamp).inDays;

  if (daysDifference < 0) {
    return 'In the future';
  }

  if (daysDifference == 0) {
    return 'Today';
  }

  if (daysDifference == 1) {
    return 'Yesterday';
  }

  final weeksAgo = daysDifference ~/ 7;
  final monthsAgo = daysDifference ~/ 30;

  if (weeksAgo > 0 && weeksAgo <= 4) {
    return '$weeksAgo week${weeksAgo > 1 ? 's' : ''} ago';
  } else if (monthsAgo > 0) {
    return '$monthsAgo month${monthsAgo > 1 ? 's' : ''} ago';
  } else {
    return '$daysDifference day${daysDifference > 1 ? 's' : ''} ago';
  }
}
