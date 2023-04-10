enum BluetoothStatus { enabled, disabled, error, unknow }

extension BluetoothStatusExt on BluetoothStatus {
  bool get isEnabled {
    return this == BluetoothStatus.enabled ? true : false;
  }
}
