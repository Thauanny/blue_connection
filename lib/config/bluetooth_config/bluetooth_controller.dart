import '../../src/module/home/domain/entities/blue_device.dart';
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

  void requestEnable() async {
    await bluetoothConfig
        .requestEnable()
        .then((value) => _bluetoothStatus = value);
    bondedDevices();
  }

  void requestDisable() async {
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

  void bondedDevices() {
    if (bluetoothStatus == BluetoothStatus.enabled) {
      bluetoothConfig.bondedDevices().then(
            (value) => _devices = value,
          );
    }
  }

  void connectDevice(Device? device) {
    if (device != null) {
      if (!_deviceStatus.isConected) {
        bluetoothConfig
            .connectDevice(device.address)
            .then((value) => _deviceStatus = value);
      }
    }
  }

  void disconnectDevice() {
    bluetoothConfig.disconnectDevice();
  }
}
