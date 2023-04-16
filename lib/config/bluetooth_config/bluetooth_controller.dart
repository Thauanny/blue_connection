import '../../src/module/shared/domain/entities/blue_device.dart';
import 'bluetooth_config.dart';
import 'bluetooth_status.dart';
import 'device_status.dart';

class BluetoothController {
  BluetoothConfigAdapter bluetoothConfig = BluetoothConfigAdapter.instance;
  List<Device> _devices = <Device>[];

  BluetoothStatus _bluetoothStatus = BluetoothStatus.disabled;
  DeviceStatus _deviceStatus = DeviceStatus.notConnected;

  BluetoothStatus get bluetoothStatus => _bluetoothStatus;
  DeviceStatus get deviceStatus => _deviceStatus;
  List<Device> get devices => _devices;

  Future<void> requestEnable() async {
    await bluetoothConfig
        .requestEnable()
        .then((value) => _bluetoothStatus = value);
  }

  Future<void> requestDisable() async {
    await bluetoothConfig
        .requestDisable()
        .then((value) => _bluetoothStatus = value);
    if (_bluetoothStatus == BluetoothStatus.disabled) _devices = [];
  }

  void dispose() {
    if (_deviceStatus.isConected) {
      bluetoothConfig.dispose();
    }
  }

  Future<void> bondedDevices() async {
    if (bluetoothStatus == BluetoothStatus.enabled) {
      await bluetoothConfig.bondedDevices().then(
            (value) => _devices = value,
          );
    }
  }

  Future<void> connectDevice(Device? device) async {
    if (device != null) {
      if (!_deviceStatus.isConected) {
        await bluetoothConfig
            .connectDevice(device.address)
            .then((value) => _deviceStatus = value);
      }
    }
  }

  Future<void> disconnectDevice() async {
    await bluetoothConfig.disconnectDevice();
  }
}
