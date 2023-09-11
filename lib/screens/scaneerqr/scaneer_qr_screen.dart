import 'package:app_movil/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String qrValue = 'Escanea aqui tus codigos Qr';

  Future<void> scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrValue = cameraScanResult!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            qrValue,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanQr,
        child: Icon(Icons.camera, color: Colors.white),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
