import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:velocity_x/velocity_x.dart";

// import 'package:path_provider/path_provider.dart';

import '../../../models/social_link_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/images.dart';
import '../../../view_model/river_pod/number_notifier.dart';
import '../widgets/horizontal_dot_tile.dart';
// import '../widgets/horizontal_dot_tile/esys_flutter_share_plus.dart';

// import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends ConsumerStatefulWidget {
  final dynamic qrData;
  const QrCodeScreen({super.key, this.qrData});

  @override
  ConsumerState<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends ConsumerState<QrCodeScreen> {
  var random = Random();
  // int _

  // String generateMultiLinkURI(List<String> qrData) {
  //   return qrData.map((link) => Uri.encodeComponent(link)).join(';');
  // }

  // String generateQRData(Map<String, dynamic> qrData) {
  //   String firstName = qrData['firstName'] ?? '';
  //   String lastName = qrData['lastName'] ?? '';
  //   String profession = qrData['profession'] ?? '';
  //   String phoneNumber = qrData['phoneNumber'] ?? '';
  //   List<SocialLinkModel> social = (qrData['socials'] as List<SocialLinkModel>?)?.cast<SocialLinkModel>() ?? [];
  //
  //   String qrString = 'First Name: $firstName\n'
  //       'Last Name: $lastName\n'
  //       'Profession: $profession\n'
  //       'Phone Number: $phoneNumber\n';
  //
  //   print('Hello data ====> $qrString ');
  //   print('Hello socials ====> $social ');
  //
  //   if (social.isNotEmpty) {
  //     qrString += 'Social:\n';
  //     social.forEach((s) {
  //       qrString += '$s\n';
  //       print(' Hello Selected social ==> $qrString');
  //     });
  //   }
  //
  //   return qrString;
  // }

  String generateQRData(UserModel userModel) {
    String firstName = userModel.firstName;
    String lastName = userModel.lastName;
    String profession = userModel.profession ?? '';
    String phoneNumber = userModel.phoneNumber;
    String email = userModel.email;
    String id = userModel.id;
    String image = userModel.image;
    List<SocialLinkModel> social = userModel.socialMediaLink ?? [];

    String socialLinksString = social
        .map((link) =>
            '${link.text},${link.imagePath},${link.conColor},${link.iconColor},${link.linkUrl}')
        .join(',');

    String userDataString =
        '$firstName;$lastName;$phoneNumber;$profession;$email;$id';
    if (image.isNotEmpty) {
      userDataString += ';$image';
    }

    String qrString = '$userDataString;$socialLinksString';

    return qrString;
  }

  // String generateQRData(UserModel userModel) {
  //   String firstName = userModel.firstName ?? '';
  //   String lastName = userModel.lastName ?? '';
  //   String profession = userModel.profession ?? '';
  //   String phoneNumber = userModel.phoneNumber ?? '';
  //   String email = userModel.email ?? '';
  //   String id = userModel.id ?? '';
  //   List<SocialLinkModel> social = userModel.socialMediaLink ?? [];
  //
  //   String socialLinksString = social.map((link) => '${link.text},${link.imagePath},${link.conColor},${link.iconColor},${link.linkUrl}').join(',');
  //
  //   String qrString = '$firstName;$lastName;$phoneNumber;$profession;$email;$id;$socialLinksString';
  //
  //   return qrString;
  // }

  void openSelectedLink(String encodedLinks, String chosenLink) {
    final decodedLinks = encodedLinks.split(';');
    final index = decodedLinks.indexOf(chosenLink);
    if (index >= 0 && index < decodedLinks.length) {
      _launchURL(decodedLinks[index]);
    } else {
      // Handle scenario where chosen link is not found (optional)
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final number = ref.watch(numberProvider);
    print('Url link ====> ${widget.qrData}');

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        title: Text(
          'QR Code',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 7,
              ),
              const HorizontalDotTile(),
              const SizedBox(
                height: 30,
              ),
              if (widget.qrData != null)
                SizedBox(
                  height: 300,
                  width: 300,
                  child: PrettyQrView.data(
                    data: generateQRData(widget.qrData),
                    decoration: PrettyQrDecoration(
                      // shape:PrettyQrSmoothSymbol(),
                      background:
                          Theme.of(context).brightness == Brightness.light
                              ? null
                              : Colors.white,
                      image: PrettyQrDecorationImage(
                        fit: BoxFit.cover,
                        // padding: const EdgeInsets.all(10),
                        image:
                            AssetImage("$imagePath/images/square_ss_logo.png"),
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 27,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Scan QR with recipient device to connect.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).brightness == Brightness.light
                        ? ProjectColors.mainPurple
                        : ProjectColors.lightishPurple,
                  ),
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 4.5,
              // ),
              const Spacer(),
              ButtonTile(
                text: 'Share',
                textColor: Colors.black,
                boxRadius: 35,
                icon: SvgPicture.asset(shareIcon),
                color: ProjectColors.mainGray,
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  );

                  final qrCode = QrCode.fromData(
                    data: generateQRData(widget.qrData!),
                    errorCorrectLevel: QrErrorCorrectLevel.H,
                  );

                  final qrImage = QrImage(qrCode);
                  final qrImageBytes = await qrImage.toImageAsBytes(
                    size: 1080,
                    format: ImageByteFormat.png,
                    decoration: PrettyQrDecoration(
                      background: Colors.white,
                      image: PrettyQrDecorationImage(
                        padding: const EdgeInsets.all(10),
                        image: AssetImage(socialIcon),
                      ),
                    ),
                  );

                  // Compress the image and write it to the file.
                  final compressedImage =
                      await FlutterImageCompress.compressWithList(
                    qrImageBytes!.buffer.asUint8List(),
                    minWidth: 1080,
                    minHeight: 1080,
                    quality: 88,
                  );

                  Navigator.pop(context);

                  Share.file(
                    'Qr Code',
                    'qrcode.png',
                    compressedImage,
                    'image/png',
                  );

                  // VxToast.show(
                  //   context,
                  //   msg: 'Shared successfully!',
                  //   bgColor: ProjectColors.fadeBlack,
                  //   textColor: Colors.white,
                  //   showTime: 5000,
                  // );

                  // Future.delayed(Duration(seconds: 4), () {
                  //       VxToast.show(context, msg: 'Shared successfully!', bgColor: Colors.black54, textColor: Colors.white);});
                  // Future.delayed(const Duration(seconds: 2), () {
                  //   return VxToast.show(
                  //     context,
                  //     msg: 'Shared',
                  //     bgColor: Colors.black54,
                  //     textColor: Colors.white,
                  //   );
                  // });
                },
              ),

              const SizedBox(
                height: 10,
              ),

              ButtonTile(
                width: double.infinity,
                text: "Download",
                boxRadius: 35,
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            color: ProjectColors.mainPurple,
                          ),
                        ),
                      );
                    },
                  );

                  final qrCode = QrCode.fromData(
                    data: generateQRData(widget.qrData!),
                    errorCorrectLevel: QrErrorCorrectLevel.H,
                  );

                  final qrImage = QrImage(qrCode);
                  final qrImageBytes = await qrImage.toImageAsBytes(
                    size: 1080,
                    format: ImageByteFormat.png,
                    decoration: PrettyQrDecoration(
                      background: Colors.white,
                      image: PrettyQrDecorationImage(
                        padding: const EdgeInsets.all(10),
                        image: AssetImage(socialIcon),
                      ),
                    ),
                  );

                  // Get the temporary directory of the device.
                  // Directory? directory = await getApplicationCacheDirectory();

                  //Get download directory of the device.
                  String? downloadDirectoryPath =
                      await getDownloadDirectoryPath();

                  // Create a file in the temporary directory.
                  // final File file = File('${directory!.path}/qr_code${random.nextInt(100)}.png');

                  print(downloadDirectoryPath);
                  // Create a file in the downloads directory
                  final File file = File(
                    '$downloadDirectoryPath/qr_code${number == 0 ? '' : '(${number.toString()})'}.png',
                  );
                  ref.read(numberProvider.notifier).incrementNumber();

                  // Compress the image and write it to the file.
                  final compressedImage =
                      await FlutterImageCompress.compressWithList(
                    qrImageBytes!.buffer.asUint8List(),
                    minWidth: 1080,
                    minHeight: 1080,
                    quality: 88,
                  );
                  await file.writeAsBytes(compressedImage, flush: true);

                  // showDialog(context: context, builder: (context){
                  //   return
                  // });

                  // infoSnackBar(
                  //   context,
                  //   'Qr Code saved to $downloadDirectoryPath',
                  //   const Duration(seconds: 8),
                  //   Colors.green,
                  // );
                  Navigator.pop(context);

                  VxToast.show(
                    context,
                    msg: 'Downloaded successfully!',
                    bgColor: ProjectColors.successColor.withOpacity(0.95),
                    textColor: Colors.white,
                    showTime: 5000,
                  );

                  // The image file is now saved in the device's temporary directory.
                  print('Image saved at ${file.path}');
                },
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
