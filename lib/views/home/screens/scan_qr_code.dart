import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/views/home/screens/preview_scan_link_screen.dart';
import 'package:socialscan/views/home/widgets/qr_scanner_overlay.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  List<String> extractedLinks = [];
  List<UserModel> extractedModelLinks = [];
  MobileScannerController _mobileScannerController = MobileScannerController();


  UserModel parseQRData(String qrData) {
    List<String> userData = qrData.split(';');
    if (userData.length != 7) {
      print('Mad error =======>');

      throw Exception('Invalid QR data format');
    }
    String firstName = userData[0];
    String lastName = userData[1];
    String phoneNumber = userData[2];
    String profession = userData[3];
    String email = userData[4];
    String id = userData[5];
    List<SocialLinkModel> socialLinks = parseSocialLinks(userData[6]);

    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      profession: profession,
      email: email,
      socialMediaLink: socialLinks,
      image: '',
    );
  }



  List<SocialLinkModel> parseSocialLinks(String socialLinksString) {
    List<String> socialLinksData = socialLinksString.split(',');
    List<SocialLinkModel> socialLinks = [];
    for (String linkData in socialLinksData) {
      List<String> linkFields = linkData.split(',');
      if (linkFields.length != 3) {
        throw Exception('Invalid social link data format');
      }
      SocialLinkModel link = SocialLinkModel(
        id: linkFields[0],
        text: linkFields[1],
        imagePath: linkFields[2],
        linkUrl: linkFields[3],
      );
      socialLinks.add(link);
    }
    return socialLinks;
  }


  @override
  void initState() {
    super.initState();

    _mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _mobileScannerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        // titleSpacing: 10,
        title: Container(
          // height: 40,
          padding: const EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: const Color(0x80000000),
            borderRadius: BorderRadius.circular(42),
          ),
          child: const Text(
            "Scan QR Code to connect",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _mobileScannerController,
            onDetect: (capture) async {
              final List<Barcode> barcodes = capture.barcodes;
              if (capture.barcodes.isEmpty) return;

              for (final barcode in barcodes) {
                print("Barcode found! ${barcode.rawValue}");
                try {
                  UserModel userModel = parseQRData(barcode.rawValue!);
                  extractedModelLinks.add(userModel);
                  if (capture.image != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PreviewScanLinkScreen(
                              data: extractedModelLinks,
                            ),
                      ),
                    );
                  }
                } on Exception catch (e) {
                  // Handle parsing exceptions (e.g., invalid format)
                  print("Error parsing QR data: $e");
                }
                // }
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return AlertDialog(
                //       title: const Text("QR Code Data"),
                //       content: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           for (var link in extractedLinks)
                //             ListTile(title: Text(link)),
                //         ],
                //       ),
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           child: const Text('OK'),
                //         ),
                //       ],
                //     );
                //   },
                // );

              }
            }
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return MobileScanner(
//     controller: MobileScannerController(
//       detectionSpeed: DetectionSpeed.noDuplicates,
//       returnImage: true,
//     ),
//     onDetect: (capture) {
//       final List<Barcode> barcodes = capture.barcodes;
//       final Uint8List? image = capture.image;
//       for (final barcode in barcodes) {
//         print("Barcode found! ${barcode.rawValue}");
//         if (capture.image != null) {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text(barcode.rawValue ?? ""),
//                   content: Image(
//                     image: MemoryImage(image!),
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text('OK'),
//                     ),
//                   ],
//                 );
//               });
//         }
//       }
//     },
//     // allowDuplicates: false,
//     // onDetect: (capture, returnImage) {
//
//     // print("Barcode found! ${capture.rawValue}");
//     // if(capture.rawBytes != null){
//     //   showDialog(context: context, builder: (context){
//     //     return AlertDialog(
//     //       title:  Text(capture.rawValue ?? ""),
//     //       content: Image(image: MemoryImage(capture.rawBytes!),),
//     //       actions: [
//     //         TextButton(
//     //           onPressed: () {
//     //             Navigator.pop(context);
//     //           },
//     //           child: const Text('OK'),
//     //         ),
//     //       ],
//     //     );
//     //   });
//     // }
//     // }
//   );
// }
