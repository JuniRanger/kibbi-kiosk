import 'package:connectivity_plus/connectivity_plus.dart';

abstract class AppConnectivity {
  AppConnectivity._();

  static Future<bool> connectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    return true;
  }
}
