import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothConfig {
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;

  final FlutterBluetoothSerial bluetoothSerial =
      FlutterBluetoothSerial.instance;

  BluetoothConnection? connection;

  bool _isEnabled = false;

  BluetoothConfig._();

  static final instance = BluetoothConfig._();

  bool get isEnabled => _isEnabled;

  bool get isConnected => (connection != null) && (connection!.isConnected);

  Future<bool?> requestEnable() async {
    return await bluetoothSerial.state.then((bluetoothState) async {
      if (bluetoothState == BluetoothState.STATE_OFF) {
        if (await bluetoothSerial.requestEnable() ?? false) {
          _isEnabled = true;
          return true;
        }
      } else {
        _isEnabled = true;
        return true;
      }
      return true;
    });
  }

  Future<bool?> requestDisable() async {
    return await bluetoothSerial.state.then(
      (bluetoothState) async {
        if (bluetoothState == BluetoothState.STATE_ON) {
          if (await bluetoothSerial.requestDisable() ?? false) {
            _isEnabled = false;
            return false;
          }
        } else {
          _isEnabled = false;
          return false;
        }
        return true;
      },
    );
  }

  void disposeBluetoth() {
    if (isConnected) {
      connection!.dispose();
      connection = null;
    }
  }

  Future<List<BluetoothDevice>> pairedDevices() async {
    List<BluetoothDevice> devices = [];
    if (isConnected) {
      try {
        devices = await bluetoothSerial.getBondedDevices();
      } on PlatformException {
        debugPrint("Error");
      }
    }
    return devices;
  }
}
