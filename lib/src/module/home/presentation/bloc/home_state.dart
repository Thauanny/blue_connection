part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeBluetoothEnabled extends HomeState {}

class HomeBluetoothDisabled extends HomeState {}

class HomeBondedDevicesReceived extends HomeState {}

class HomeBluetoothDisposed extends HomeState {}

class HomeDeviceConnected extends HomeState {}

class HomeDeviceDisconneted extends HomeState {}
