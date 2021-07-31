import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, ScanModel scan ) async {

  if ( scan.tipo =='http'){
  
  await canLaunch(scan.valor) ? await launch(scan.valor) : throw 'Could not launch ${scan.valor}';

  
  } else {
    Navigator.pushNamed(context, 'mapaview', arguments: scan );
  }
  
  


}
    


