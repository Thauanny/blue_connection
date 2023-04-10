class Device {
  final String name;
  final String address;
  final bool isConnected;

  Device({
    required this.name,
    required this.address,
    required this.isConnected,
  });

  @override
  operator ==(Object other) {
    return other is Device && other.address == address;
  }

  @override
  int get hashCode => address.hashCode;
}
