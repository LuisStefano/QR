import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';
import 'package:qrreaderapp/src/pages/mapaView_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/pages/qrview_page.dart';


Map<String, WidgetBuilder> getApplicationRoutes(){
  
  return <String, WidgetBuilder>{
    '/'             : ( BuildContext context ) => HomePage(),
    'direcciones'   : ( BuildContext context ) => DiereccionesPage(),
    'mapas'         : ( BuildContext context ) => MapasPage(),
    'qrview'        : ( BuildContext context ) => QrView(),
    'mapaview'      : ( BuildContext context ) => MapaPageView()

  };
}