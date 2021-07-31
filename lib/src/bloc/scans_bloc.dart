import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators{

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal(){

    obtenerScans();

  }

  final _scanController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansSream => _scanController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansSreamHttp => _scanController.stream.transform(validarHttp);


  dispose(){
    _scanController.close();
  }


  

  obtenerScans() async {
    _scanController.sink.add( await DBProvider.db.getAllScans() );
  }

  agregarScan( ScanModel scan ) async {
    await DBProvider.db.nuevoScan( scan );
    print('GUARDANDO DATOS');

    obtenerScans();
  }

  deleteScan( int id ) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}