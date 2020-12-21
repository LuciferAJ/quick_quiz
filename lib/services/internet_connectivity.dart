import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
class InternetConnectivity{
static Connectivity connectivity = Connectivity();

static Future<void> initConnectivity() async {
  ConnectivityResult result;
  try {
    result = await connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    print(e.toString());
  }
  return updateConnectionStatus(result);
}
static Future<void> updateConnectionStatus(ConnectivityResult result) async {
  switch (result) {
    case ConnectivityResult.wifi:
      break;
    case ConnectivityResult.mobile:
      break;
    case ConnectivityResult.none:
      Fluttertoast.showToast(msg: 'No Internet Connection!!');
      break;
    default:
      print("Failed to get Connection Status");
      break;
  }
}}