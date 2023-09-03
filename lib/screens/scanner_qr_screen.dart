import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String qrValue = 'Codigo Qr';

  Future <void> scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrValue = cameraScanResult!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Escanear Qr',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Escanear Qr',
          ),
        ),
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
        child: const Icon(Icons.camera),
      ),
      ),
    );
  }
}
