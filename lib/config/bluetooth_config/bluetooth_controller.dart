import '../../src/module/shared/domain/entities/blue_device.dart';
import 'bluetooth_config.dart';
import 'bluetooth_status.dart';
import 'device_status.dart';

class BluetoothController {
  BluetoothConfigAdapter bluetoothConfig = BluetoothConfigAdapter.instance;
  List<Device> _devices = <Device>[];

  BluetoothStatus _bluetoothStatus = BluetoothStatus.disabled;

  BluetoothStatus get bluetoothStatus => _bluetoothStatus;
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
    bluetoothConfig.dispose();
  }

  Future<void> scanDevices() async {
    if (bluetoothStatus == BluetoothStatus.enabled) {
      await bluetoothConfig.scanDevices().then(
            (value) => _devices = value,
          );
    }
  }

  Future<void> connectDevice({required Device device}) async {
    await bluetoothConfig.connectDevice(device).then((value) {
      device.status = DeviceStatus.connected;
    });
  }

  Future<void> disconnectDevice({required Device device}) async {
    _devices = [];
    await bluetoothConfig
        .disconnectDevice(device)
        .then((value) => device.status = value);
  }
}
