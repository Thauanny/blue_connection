enum BluetoothStatus { enabled, disabled, error, unknow }

extension BluetoothStatusExt on BluetoothStatus {
  bool get enabled {
    print(this);
    return this == BluetoothStatus.enabled ? true : false;
  }
}
