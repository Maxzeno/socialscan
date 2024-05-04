import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    print("Scanned QR Data: $qrData");
    List<String> userData = qrData.split(';');
    print('Users ===> $userData');
    if (userData.length < 6) {
      throw Exception('Invalid QR data format');
    }
    String firstName = userData[0];
    String lastName = userData[1];
    String phoneNumber = userData[2];
    String profession = userData[3];
    String email = userData[4];
    String id = userData[5];
    String image = '';
    List<SocialLinkModel> socialLinks = [];

    if (userData.length > 6) {
      if (userData[6].startsWith('https')) {
        image = userData[6];
      } else {
        socialLinks = parseSocialLinks(userData[6]);
      }
    }

    if (userData.length > 7) {
      socialLinks = parseSocialLinks(userData[7]);
    }

    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
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

  ImagePicker picker = ImagePicker();
  // XFile? image;

  bool isLoaderVisible = false;

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
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

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
                    print('parseqrdata ===> $userModel');
                    print('=======> checking ');
                    extractedModelLinks.add(userModel);
                    print("Extracted Model Links: $extractedModelLinks");
                    if (capture.image != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PreviewScanLinkScreen(
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
              }),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _mobileScannerController.switchCamera(),
                  child: ValueListenableBuilder(
                    valueListenable: _mobileScannerController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state) {
                        case CameraFacing.front:
                          return ScanQRCircleWidget(
                            width: 49,
                            height: 49,
                            // bgColor: Colors.transparent,
                            bgGradient: RadialGradient(
                              colors: [
                                // Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(0.6),
                                // Colors.white.withOpacity(0.8),
                              ],
                            ),
                            icon: const Icon(
                              Icons.cameraswitch_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          );
                        case CameraFacing.back:
                          return ScanQRCircleWidget(
                            width: 49,
                            height: 49,
                            bgColor: Colors.black.withOpacity(0.5),
                            icon: const Icon(
                              Icons.cameraswitch_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          );
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    // if (image != null) {
                    //   setState(() {
                    //     isLoaderVisible = true;
                    //   });
                    //   print("Image path: ${image!.path}");
                    //   final qrData = await _mobileScannerController
                    //       .analyzeImage(image!.path)
                    //       .then((value) {
                    //     if (value) {
                    //       setState(() {
                    //         isLoaderVisible = false;
                    //       });

                    //       Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (_) => PreviewScanLinkScreen(
                    //                 data: extractedLinks,
                    //               ),
                    //             ),
                    //           );

                    //       // final List<Barcode> barcodes = image.barcodes;
                    //       // // final Uint8List? image = capture.image;
                    //       // for (final barcode in barcodes) {
                    //       //   print("Barcode found! ${barcode.rawValue}");
                    //       //   extractedLinks = barcode.rawValue?.split(';') ?? [];
                    //       //   if (capture.image != null) {
                    //       //     // for (var link in extractedLinks) {
                    //       //     Navigator.push(
                    //       //       context,
                    //       //       MaterialPageRoute(
                    //       //         builder: (_) => PreviewScanLinkScreen(
                    //       //           data: extractedLinks,
                    //       //         ),
                    //       //       ),
                    //       //     );
                    //       //   }
                    //       // }
                    //     }
                    //   });

                    //   print("QR Data: $qrData");

                    //   // if (_mobileScannerController.analyzeImage(image!.path) == true) {

                    //   // }
                    // } else {
                    //   setState(() {
                    //     isLoaderVisible = false;
                    //   });

                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return const Text("No QR data found in this image");
                    //       });
                    // }
                    // setState(() {});
                    if (image != null) {
                      setState(() {
                        isLoaderVisible = true;
                      });
                      print("Image path: ${image.path}");
                      final bool qrData = await _mobileScannerController
                          .analyzeImage(image.path);
                      if (qrData) {
                        setState(() {
                          isLoaderVisible = false;
                        });

                        print("QR code Data available");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PreviewScanLinkScreen(
                              data: extractedModelLinks,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          isLoaderVisible = false;
                        });

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  const Text("No QR data found in this image"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: ScanQRCircleWidget(
                    width: 71,
                    height: 71,
                    bgColor: Colors.black.withOpacity(0.5),
                    icon: const Icon(
                      Icons.photo_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _mobileScannerController.toggleTorch(),
                  child: ValueListenableBuilder(
                    valueListenable: _mobileScannerController.torchState,
                    builder: (context, state, child) {
                      switch (state) {
                        case TorchState.off:
                          return ScanQRCircleWidget(
                            width: 49,
                            height: 49,
                            bgColor: Colors.black.withOpacity(0.5),
                            icon: const Icon(
                              Icons.flashlight_on_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          );
                        case TorchState.on:
                          return ScanQRCircleWidget(
                            width: 49,
                            height: 49,
                            // bgColor: ProjectColors.mainPurple,
                            bgGradient: RadialGradient(
                              colors: [
                                // Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(0.6),
                                // Colors.white.withOpacity(0.8),
                              ],
                            ),
                            icon: const Icon(
                              Icons.flashlight_on_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isLoaderVisible,
            child: Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 40,
                height: 40,
                color: Colors.black.withOpacity(0.8),
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScanQRCircleWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget icon;
  final Color? bgColor;
  final Gradient? bgGradient;

  const ScanQRCircleWidget({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    this.bgColor,
    this.bgGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        gradient: bgGradient,
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        shape: BoxShape.circle,
      ),
      child: icon,
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
