import 'package:blue_connection/config/bluetooth_config/bluetooth_config.dart';
import 'package:blue_connection/config/bluetooth_config/bluetooth_status.dart';
import 'package:blue_connection/config/bluetooth_config/device_status.dart';
import 'package:blue_connection/src/module/home/domain/entities/blue_device.dart';
import 'package:flutter/material.dart';

//TODO SUBSTITUIR POR BLOC
class HomePageController {
  BluetoothConfigAdapter bluetoothConfig = BluetoothConfigAdapter.instance;
  ValueNotifier<List<Device>> devices = ValueNotifier<List<Device>>([]);
  final ValueNotifier<BluetoothStatus> _bluetoothStatus =
      ValueNotifier<BluetoothStatus>(BluetoothStatus.disabled);
  final ValueNotifier<DeviceStatus> _deviceStatus =
      ValueNotifier<DeviceStatus>(DeviceStatus.notConnected);

  ValueNotifier<BluetoothStatus> get bluetoothStatus => _bluetoothStatus;
  ValueNotifier<DeviceStatus> get deviceStatus => _deviceStatus;

  void requestEnable() async {
    await bluetoothConfig
        .requestEnable()
        .then((value) => _bluetoothStatus.value = value);
    pairedDevices();
  }

  void requestDisable() async {
    await bluetoothConfig
        .requestDisable()
        .then((value) => _bluetoothStatus.value = value);
    if (_bluetoothStatus.value == BluetoothStatus.disabled) devices.value = [];
  }

  void dispose() {
    if (_deviceStatus.value.isConected) {
      bluetoothConfig.dispose();
    }
  }

  void pairedDevices() {
    if (bluetoothStatus.value == BluetoothStatus.enabled) {
      bluetoothConfig.pairedDevices().then(
            (value) => devices.value = value,
          );
    }
  }

  void connectDevice(Device? device) {
    if (device != null) {
      if (!_deviceStatus.value.isConected) {
        bluetoothConfig
            .connectDevice(device.address)
            .then((value) => _deviceStatus.value = value);
      }
    }
  }

  void disconnectDevice() {
    bluetoothConfig.disconnectDevice();
  }

  List<DropdownMenuItem<Device>> getDeviceItems(List<Device> deviceList) {
    List<DropdownMenuItem<Device>> items = [];

    if (deviceList.isEmpty) {
      items.add(
        const DropdownMenuItem(
          child: Text('Selecione'),
        ),
      );
    } else {
      for (var device in deviceList) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(device.name),
        ));
      }
    }
    return items;
  }
}
