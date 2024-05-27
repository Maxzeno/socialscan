import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/lists/extracted_model_links.dart';
import 'package:socialscan/utils/services/firebase_services.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/screens/preview_scan_link_screen.dart';
import 'package:socialscan/views/home/widgets/qr_scanner_overlay.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  List<String> extractedLinks = [];

  MobileScannerController _mobileScannerController = MobileScannerController();

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
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
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
              setState(() {
                isLoaderVisible = true;
              });
              final List<Barcode> barcodes = capture.barcodes;
              if (capture.barcodes.isEmpty) return;

              for (final barcode in barcodes) {
                print("Barcode found! ${barcode.rawValue}");
                try {
                  UserModel userModel = parseQRData(barcode.rawValue!);
                  print('parseqrdata ===> $userModel');
                  print('=======> checking ');
                  await FirebaseService()
                      .addScannedUserToNetwork(barcode.rawValue!);
                  extractedModelLinks.add(userModel);
                  // FirebaseService().addUserToList(userModel);
                  print("Extracted Model Links: $extractedModelLinks");
                  setState(() {
                    isLoaderVisible = false;
                  });
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
                  setState(() {
                    isLoaderVisible = false;
                  });
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
            },
          ),
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
              child: Stack(
                children: [
                  Container(
                    // width: 40,
                    // height: 40,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
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
