import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



// ignore: use_key_in_widget_constructors
class QRCodeScannerScreen extends StatefulWidget {
  
  static const String nameRoute= "qr_scanner_screen";



  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _qrController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        leading: IconButton(onPressed:()=>Navigator.of(context).pop(),icon: const Icon(Icons.arrow_back)),
        
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _qrController = controller;
    });

    _qrController.scannedDataStream.listen((scanData) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('QR Code Scanned'),
            content: Text('Data: $scanData'),
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
      ));
  }

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }
}
