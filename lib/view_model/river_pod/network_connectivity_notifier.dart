import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityStatus>((ref) {
  return ConnectivityNotifier();
});

class ConnectivityNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityNotifier() : super(ConnectivityStatus.Offline) {
    _init();
  }

  Future<void> _init() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _setStatus(result);
    });

    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    _setStatus(connectivityResult);
  }

  void _setStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        state = ConnectivityStatus.WiFi;
        Fluttertoast.showToast(
          msg: 'WiFi connected',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        print('Wifi ===>');
        break;
      case ConnectivityResult.mobile:
        state = ConnectivityStatus.Cellular;
        print('Mobile ===>');

        break;
      case ConnectivityResult.none:
        state = ConnectivityStatus.Offline;
        print('Offline ===>');

        Fluttertoast.showToast(
          msg: 'No internet connection',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
    }
  }
}
