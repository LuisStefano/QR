import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;


class QrView extends StatefulWidget {

  @override
  _QrViewState createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final scansBloc = new ScansBloc();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 280.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor   : Colors.green,
        borderRadius  : 20,
        borderLength  : 30,
        borderWidth   : 10,
        cutOutSize    : scanArea    
      ),
      onPermissionSet: (ctrl, p) => {
        _onPermissionSet(context, ctrl, p)
      },
    );
  }

  void _onQRViewCreated(QRViewController controller){
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {

      result = scanData;
      String futureString= result!.code;

      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan( scan );
       
      await controller.pauseCamera();  
      Navigator.pushNamed(context, '/');
      
      if( Platform.isIOS){
        Future.delayed( Duration( milliseconds: 750), (){
          utils.openScan(context, scan);
        });
      }else{
          utils.openScan(context, scan);
      }
      setState(() {});
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

   
}