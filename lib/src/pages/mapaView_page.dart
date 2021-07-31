import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/global/environment.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPageView extends StatefulWidget {

  @override
  _MapaPageViewState createState() => _MapaPageViewState();
}

class _MapaPageViewState extends State<MapaPageView> {

  final MapController map = new MapController();
  String estiloMapa = 'satellite';

  @override
  Widget build(BuildContext context) {

    final ScanModel? scan = ModalRoute.of(context)!.settings.arguments as ScanModel?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan!.getLatLng(), 15);
            },  
          )
        ],
      ),
      body: _crearFlutterMap( scan! ),
      floatingActionButton: _styleMap( context ),
    );
  }

  Widget _styleMap(BuildContext context){
    return FloatingActionButton(
      child: Icon( Icons.repeat ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){

        if( estiloMapa == 'satellite'){
          estiloMapa = 'mapbox-streets-v8';
        } else {
          estiloMapa = 'satellite';
        }
        setState(() { });
      },
    );
  }

  Widget _crearFlutterMap( ScanModel scan ){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores( scan )
      ],
    );
  }

  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': Environment.accesToken,
        'id':'mapbox.$estiloMapa'
      }
    );
  }

  _crearMarcadores( ScanModel scan ){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: ( context ) => Container(
            child: Icon( Icons.location_on, size: 70.0, color: Theme.of(context).primaryColor,),
          )
        )
      ]
    );
  }
}

