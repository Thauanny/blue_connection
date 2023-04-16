import 'package:bloc/bloc.dart';
import 'package:blue_connection/config/bluetooth_config/bluetooth_controller.dart';
import 'package:blue_connection/config/bluetooth_config/bluetooth_status.dart';
import 'package:blue_connection/src/module/shared/domain/entities/blue_device.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  BluetoothController bluetoothController;
  List<Device> bondedDevices = [];
  HomeBloc(this.bluetoothController) : super(HomeState.empty()) {
    on(_onEvent);
  }

  Future<void> _onEvent(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeState.loading());
    await event.when(enabledBluetooth: () async {
      await bluetoothController.requestEnable();
      bluetoothController.bluetoothStatus == BluetoothStatus.error
          ? emit(HomeState.error())
          : emit(HomeState.sucessEnabledBluetooth());
    }, disabledBluetooth: () async {
      await bluetoothController.requestDisable();
      emit(HomeState.sucessDisabledBluetooth());
    }, requestBondedDevices: () async {
      await bluetoothController
          .bondedDevices()
          .timeout(const Duration(seconds: 5), onTimeout: () {
        emit(HomeState.error());
      });
      bondedDevices = bluetoothController.devices;
      emit(HomeState.sucessBondedDevices());
    }, requestBluetoothDispose: () {
      bluetoothController.dispose();
      emit(HomeState.sucessBluetoothDisposed());
    }, requestConnectDevice: (device) async {
      await bluetoothController.connectDevice(device);
      emit(HomeState.sucessDeviceConnected());
    }, requestDisconnectDevice: () async {
      await bluetoothController.disconnectDevice();
      emit(HomeState.sucessDeviceDisconnected());
    });
  }
}
