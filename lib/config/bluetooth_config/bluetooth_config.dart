import 'dart:async';

import 'package:blue_connection/config/bluetooth_config/device_status.dart';
import 'package:blue_connection/src/module/shared/domain/entities/blue_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart'
    hide BluetoothDevice;

import 'bluetooth_status.dart';

class BluetoothConfigAdapter {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final FlutterBluetoothSerial bluetoothSerial =
      FlutterBluetoothSerial.instance;
  List<BluetoothDevice> devices = [];
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

  Future<List<Device>> scanDevices() async {
    List<Device> _devices = [];

    try {
      await flutterBlue.startScan(
        timeout: const Duration(seconds: 5),
        allowDuplicates: false,
        scanMode: ScanMode.balanced,
      );
      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          devices.add(r.device);
        }
      });
      await flutterBlue.stopScan();
      await Future.delayed(const Duration(seconds: 5));
      for (var element in devices) {
        _devices.add(
          Device(
              name: element.name,
              address: '',
              status: DeviceStatus.notConnected),
        );
      }

      return _devices;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.stacktrace);
      return _devices;
    } catch (e) {
      return _devices;
    }
  }

  Future<DeviceStatus> connectDevice(Device device) async {
    try {
      late DeviceStatus status;
      BluetoothDevice _device =
          devices.firstWhere((element) => element.name == device.name);
      await _device
          .connect(timeout: const Duration(seconds: 4))
          .onError(
            (error, stackTrace) => status = DeviceStatus.notConnected,
          )
          .then(
            (value) => status = DeviceStatus.connected,
          );
      return status;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.stacktrace);
      return DeviceStatus.notConnected;
    } catch (e) {
      return DeviceStatus.notConnected;
    }
  }

  Future<DeviceStatus> disconnectDevice() async {
    // try {
    //   await connection?.close().then((value) {
    //     dispose();
    //   });
    //   return connection == null
    //       ? DeviceStatus.disconnected
    //       : DeviceStatus.connected;
    // } on PlatformException catch (e) {
    //   debugPrint(e.message);
    //   debugPrint(e.stacktrace);
    //   return DeviceStatus.notConnected;
    // } catch (e) {
    //   return DeviceStatus.notConnected;
    // }
    return DeviceStatus.disconnected;
  }

  void dispose() {
    // if (connection != null) connection!.dispose();
    // connection = null;
  }
}
