import 'dart:async';
import 'dart:io';
import 'package:cicero_app/core/common/widgets/no_internet_screen.dart';
import 'package:cicero_app/features/auth/presentation/pages/login_page.dart';
import 'package:cicero_app/features/auth/presentation/pages/signup_page.dart';
import 'package:cicero_app/features/blog/presentation/pages/blog_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../utils/navigation_service.dart';

class ConnectionStatusListener {
  static final _singleton = ConnectionStatusListener._internal();
  ConnectionStatusListener._internal();
  bool hasShownNoInternet = false;
  final Connectivity _connectivity = Connectivity();
  static ConnectionStatusListener getInstance() => _singleton;
  bool hasConnection = false;
  StreamController connectionChangeController = StreamController.broadcast();
  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(List<ConnectivityResult> result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }
}

updateConnectivity(
  dynamic hasConnection,
  ConnectionStatusListener connectionStatus,
) {
  if (!hasConnection) {
    connectionStatus.hasShownNoInternet = true;
    Navigator.of(NavigationService.navigatorKey.currentContext!).push(
      MaterialPageRoute(builder: (context) => const NoInternetScreen()),
    );
  } else {
    if (connectionStatus.hasShownNoInternet) {
      connectionStatus.hasShownNoInternet = false;
      Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
    }
  }
}

initNoInternetListener(BuildContext context) async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  await connectionStatus.initialize();
  if (!connectionStatus.hasConnection) {
    updateConnectivity(false, connectionStatus);
  }
  connectionStatus.connectionChange.listen((event) {
    print("initNoInternetListener $event");
    updateConnectivity(event, connectionStatus);
  });
}
