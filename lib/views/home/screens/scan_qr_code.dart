
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
    return Stack(
      children: [
        MobileScanner(
          controller: _mobileScannerController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            // final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              print("Barcode found! ${barcode.rawValue}");
              setState(() {
                extractedLinks = barcode.rawValue?.split('|') ?? [];
              });
              if (capture.image != null) {
                for (var link in extractedLinks) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PreviewScanLinkScreen(
                              data: link,
                            )),
                  );
                }
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
          },
        ),

        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
      ],
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
