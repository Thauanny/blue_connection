import 'package:bloc/bloc.dart';
import 'package:blue_connection/config/bluetooth_config/bluetooth_controller.dart';
import 'package:blue_connection/src/module/home/domain/entities/blue_device.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  BluetoothController bluetoothController;
  List<Device> bondedDevices = [];
  HomeBloc(this.bluetoothController) : super(HomeInitial()) {
    on<HomeEvent>(
      (event, emit) {
        if (event is HomeRequestEnableBluetooth) {
          bluetoothController.requestEnable();
          emit(HomeBluetoothEnabled());
        } else if (event is HomeRequesDisableBluetooth) {
          bluetoothController.requestDisable();
          emit(HomeBluetoothDisabled());
        } else if (event is HomeRequesBondedDevices) {
          bluetoothController.bondedDevices();
          bondedDevices = bluetoothController.devices;
          emit(HomeBondedDevicesReceived());
        } else if (event is HomeRequestBluetoothDispose) {
          bluetoothController.dispose();
          emit(HomeBluetoothDisposed());
        } else if (event is HomeRequestConnectDevice) {
          bluetoothController.connectDevice(event.device);
          emit(HomeDeviceConnected());
        } else if (event is HomeRequestDisconnetDevice) {
          bluetoothController.disconnectDevice();
          emit(HomeDeviceDisconneted());
        }
      },
    );
  }
}
