part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeRequestEnableBluetooth extends HomeEvent {}

class HomeRequesDisableBluetooth extends HomeEvent {}

class HomeRequesBondedDevices extends HomeEvent {}

class HomeRequestBluetoothDispose extends HomeEvent {}

class HomeRequestConnectDevice extends HomeEvent {
  final Device? device;
  HomeRequestConnectDevice({
    required this.device,
  });
}

class HomeRequestDisconnetDevice extends HomeEvent {}
