import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/screens/mes_tontine/addTontine.dart';
import 'package:tontino/screens/transfert/transfert.dart';
import 'package:tontino/services/Colors.dart';

class ScreenQrcode extends StatefulWidget {
  const ScreenQrcode({Key? key, this.typeScanner, this.idTontine, this.userInfo})
      : super(key: key);

  final int? typeScanner; // 0: transfert, 1:intergrer tontine
  final int? idTontine;
  final User? userInfo;

  @override
  _ScreenQrcodeState createState() => _ScreenQrcodeState();
}

class _ScreenQrcodeState extends State<ScreenQrcode> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 160.0
        : 320.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Scanner le QR code",
          style: TextStyle(fontSize: 18, color: ColorTheme.primaryColorWhite),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              setState(() {
                controller?.pauseCamera();
                Navigator.pop(context);
              });
            }),
            icon: Icon(Icons.close)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // if (result != null)
                  //   Text(
                  //     'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                  //     style: TextStyle(
                  //         color: ColorTheme.primaryColorWhite, fontSize: 8),
                  //   )
                  // else
                  //   Text('Scan a code',
                  //       style: TextStyle(
                  //           color: ColorTheme.primaryColorWhite, fontSize: 8)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.toggleFlash();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getFlashStatus(),
                  //             builder: (context, snapshot) {
                  //               return Text('Flash: ${snapshot.data}');
                  //             },
                  //           )),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.flipCamera();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getCameraInfo(),
                  //             builder: (context, snapshot) {
                  //               if (snapshot.data != null) {
                  //                 return Text(
                  //                     'Camera facing ${describeEnum(snapshot.data!)}');
                  //               } else {
                  //                 return const Text('loading');
                  //               }
                  //             },
                  //           )),
                  //     )
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.pauseCamera();
                      //     },
                      //     child: const Text('pause',
                      //         style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('Rafraichir',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 320.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorTheme.primaryColorBlue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        // this.controller?.pauseCamera();

        print(result!.code);

        // dynamic dataScanner = jsonDecode((result!.code)!.toString());

        String dataScanner = (result!.code).toString();
        // dynamic dataScanner = jsonDecode(user.toString());
        print("avant ${jsonDecode(dataScanner).runtimeType}");
        print("avant ${jsonDecode(jsonDecode(dataScanner))['tel']}");

        var tel = jsonDecode(jsonDecode(dataScanner))['tel'];
        // var periodicite = jsonDecode(jsonDecode(dataScanner))['periodicite'];

        if (tel != null && widget.typeScanner == 0) {
          print("apres ${jsonDecode(dataScanner)}");
          this.controller?.pauseCamera();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      Transfert(tel: jsonDecode(dataScanner), user: widget.userInfo,))));
        } else if (tel != null &&
            widget.typeScanner == 1 &&
            widget.idTontine != null) {
          print("Integration de la tontine");
          this.controller?.pauseCamera();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => AddTontine(
                        infoUseer: jsonDecode(dataScanner),
                        idTontine: widget.idTontine!.toInt(),
                      ))));
        }
      });
    });
  }

  _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) async {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    } else {
      if (Platform.isAndroid) {
        await controller!.pauseCamera();
      }
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
