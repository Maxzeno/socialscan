import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';

import '../models/social_link_model.dart';

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
String whatsApp = 'Whats app';
String twitter = 'X';
String linkedin = 'LinkedIn';
String orContinueWith = 'or continue with';
String dontHaveAnAccount = 'Don\'t have an account?';
String helloWelcomeBack = 'Hello\nWelcome Back';
String settings = 'Settings';
String name = 'Name';
String mySocials = 'My socials';
String profession = 'Profession';
String phone = 'Phone';
String addNew = 'Add New';
String general = 'General';
String profile = 'Profile';
String changePassword = 'Change Password';
String theme = 'Theme';
String whileConnecting = 'While Connecting';
String sharePhoneNumber = 'Share phone number';
String shareEmail = 'Share email';
String davidRay = 'David Ray';
String helloDavid = 'Hello David';
String profileEmail = 'davidray@gmail.com';
String profileImage =
    'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.1700460183.1708041600&semt=ais';
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
final List<SocialLinkModel> socialLinks = [
  SocialLinkModel(
    text: faceBook,
    imagePath: faceBookIcon,
    conColor: ProjectColors.fb,
    iconColor: ProjectColors.fb.withOpacity(0.5),
  ),
  SocialLinkModel(
    text: instagram,
    imagePath: instagramIcon,
    conColor: ProjectColors.ig,
    iconColor: ProjectColors.ig.withOpacity(0.5),
  ),
  SocialLinkModel(
    text: whatsApp,
    imagePath: whatsAppIcon,
    conColor: ProjectColors.wsa,
    iconColor: ProjectColors.wsa.withOpacity(0.5),
  ),
  SocialLinkModel(
    text: twitter,
    imagePath: twitterIcon,
    conColor: ProjectColors.x,
    iconColor: ProjectColors.x.withOpacity(0.5),
  ),
  SocialLinkModel(
    text: linkedin,
    imagePath: linkedInIcon,
    conColor: ProjectColors.li,
    iconColor: ProjectColors.li.withOpacity(0.5),
  ),
];
