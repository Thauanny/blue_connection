import 'package:blue_connection/config/bluetooth_config/device_status.dart';
import 'package:blue_connection/src/module/shared/domain/entities/blue_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'bluetooth_status.dart';

class BluetoothConfigAdapter {
  final FlutterBluetoothSerial bluetoothSerial =
      FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;

  BluetoothConfigAdapter._();

  static final instance = BluetoothConfigAdapter._();

  Future<BluetoothStatus> requestEnable() async {
    BluetoothStatus bluetoothStatus = BluetoothStatus.unknow;
    try {
      await bluetoothSerial.requestEnable().then(
        (value) {
          if (value ?? false) {
            bluetoothStatus = BluetoothStatus.enabled;
          } else {
            bluetoothStatus = BluetoothStatus.disabled;
          }
        },
        onError: (_) => bluetoothStatus = BluetoothStatus.error,
      );

      return bluetoothStatus;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.stacktrace);
      return bluetoothStatus = BluetoothStatus.error;
    } catch (e) {
      return bluetoothStatus = BluetoothStatus.error;
    }
  }

  Future<BluetoothStatus> requestDisable() async {
    BluetoothStatus bluetoothStatus = BluetoothStatus.unknow;
    try {
      await bluetoothSerial.requestDisable().then(
        (value) {
          if (value ?? false) {
            bluetoothStatus = BluetoothStatus.disabled;
          } else {
            bluetoothStatus = BluetoothStatus.enabled;
          }
        },
        onError: (_) => bluetoothStatus = BluetoothStatus.error,
      );
      return bluetoothStatus;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.stacktrace);
      return bluetoothStatus = BluetoothStatus.error;
    } catch (e) {
      return bluetoothStatus = BluetoothStatus.error;
    }
  }

  Future<List<Device>> bondedDevices() async {
    List<Device> devices = [];
    try {
      await bluetoothSerial.getBondedDevices().then((value) {
        for (var element in value) {
          devices.add(
            Device(
              address: element.address,
              isConnected: element.isConnected,
              name: element.name ?? 'default',
            ),
          );
        }
      }, onError: (_) => devices = []);
      return devices;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.stacktrace);
      return devices;
    } catch (e) {
      return devices;
    }
  }

  Future<DeviceStatus> connectDevice(String address) async {
    try {
      await BluetoothConnection.toAddress(address);
      return connection != null
          ? connection!.isConnected
              ? DeviceStatus.connected
              : DeviceStatus.disconnected
          : DeviceStatus.notConnected;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.stacktrace);
      return DeviceStatus.notConnected;
    } catch (e) {
      return DeviceStatus.notConnected;
    }
  }

  Future<DeviceStatus> disconnectDevice() async {
    try {
      await connection?.close().then((value) {
        dispose();
      });
      return connection == null
          ? DeviceStatus.disconnected
          : DeviceStatus.connected;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.stacktrace);
      return DeviceStatus.notConnected;
    } catch (e) {
      return DeviceStatus.notConnected;
    }
  }

  void dispose() {
    if (connection != null) connection!.dispose();
    connection = null;
  }
}
