import 'package:blue_connection/config/bluetooth_config/device_status.dart';

class Device {
  final String name;
  final String address;
  final DeviceStatus status;

  Device({
    required this.name,
    required this.address,
    required this.status,
  });

  @override
  operator ==(Object other) {
    return other is Device && other.address == address;
  }

  @override
  int get hashCode => address.hashCode;
}
