import 'package:connectivity_plus/connectivity_plus.dart';

/// Connection Service
class ConnectionService {
  /// Pass [clearDataList] and [getDataList] functions
  /// This service will check and monitor device network connectivity
  ConnectionService({required this.clearDataList, required this.getDataList});

  final Connectivity connectivity = Connectivity();
  bool isConnectionAvailable = false;
  final Function clearDataList;
  final Function getDataList;

  Future<bool> isInternetConnectionAvailable() async {
    isConnectionAvailable = true;
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      clearDataList();
      isConnectionAvailable = false;
    } else {
      getDataList();
      isConnectionAvailable = true;
    }

    return isConnectionAvailable;
  }

  void watchConnectivity() {
    connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        clearDataList();
        isConnectionAvailable = false;
      } else {
        getDataList();
        isConnectionAvailable = true;
      }
    });
  }
}
