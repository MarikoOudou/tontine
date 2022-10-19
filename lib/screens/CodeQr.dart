import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tontino/services/Colors.dart';

class CodeQr extends StatefulWidget {
  const CodeQr({
    Key? key,
    required this.size,
    required this.dataQR,
    required this.sizeQRCODE,
    required this.foregroundColor,
  }) : super(key: key);

  final Size size;
  final String dataQR;
  final double sizeQRCODE;
  final Color foregroundColor;

  @override
  _CodeQrState createState() => _CodeQrState();
}

class _CodeQrState extends State<CodeQr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      // height: widget.size.height,
      // width: widget.size.width,
      child: Center(
        child: QrImage(
          foregroundColor: widget.foregroundColor,
          padding: EdgeInsets.zero,
          data: widget.dataQR,
          version: QrVersions.auto,
          size: widget.sizeQRCODE,
          gapless: false,
        ),
      ),
    );
  }
}
