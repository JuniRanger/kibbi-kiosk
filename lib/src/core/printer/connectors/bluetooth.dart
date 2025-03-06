import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../discovery.dart';
import '../models/printer_device.dart';
import '../printer.dart';

class BluetoothPrinterInput extends BasePrinterInput {
  final String address;
  final String? name;
  final bool isBle;
  final bool autoConnect;

  BluetoothPrinterInput({
    required this.address,
    this.name,
    this.isBle = false,
    this.autoConnect = false,
  });
}

class BluetoothPrinterDevice {
  final String? address;

  BluetoothPrinterDevice({required this.address});
}

class BluetoothPrinterConnector
    implements PrinterConnector<BluetoothPrinterInput> {
  // ignore: unused_element
  BluetoothPrinterConnector._({this.address = "", this.isBle = false}) {
    if (Platform.isAndroid) {
      flutterPrinterChannel.setMethodCallHandler((MethodCall call) {
        _methodStreamController.add(call);
        return Future(() => null);
      });
    }

    if (Platform.isIOS) {
      iosChannel.setMethodCallHandler((MethodCall call) {
        _methodStreamController.add(call);
        return Future(() => null);
      });
    }

    if (Platform.isAndroid) {
      flutterPrinterEventChannelBT.receiveBroadcastStream().listen((data) {
        if (data is int) {
          _status = BTStatus.values[data];
          _statusStreamController.add(_status);
        }
      });
    }

    if (Platform.isIOS) {
      iosStateChannel.receiveBroadcastStream().listen((data) {
        if (data is int) {
          _status = BTStatus.values[data];
          _statusStreamController.add(_status);
        }
      });
    }
  }

  static final BluetoothPrinterConnector _instance =
      BluetoothPrinterConnector._();

  static BluetoothPrinterConnector get instance => _instance;

  Stream<MethodCall> get _methodStream => _methodStreamController.stream;
  final StreamController<MethodCall> _methodStreamController =
      StreamController.broadcast();
  final PublishSubject _stopScanPill = PublishSubject();

  final BehaviorSubject<bool> _isScanning = BehaviorSubject.seeded(false);

  Stream<bool> get isScanning => _isScanning.stream;

  final BehaviorSubject<List<PrinterDevice>> _scanResults =
      BehaviorSubject.seeded([]);

  Stream<List<PrinterDevice>> get scanResults => _scanResults.stream;

  Stream<BTStatus> get _statusStream => _statusStreamController.stream;
  final StreamController<BTStatus> _statusStreamController =
      StreamController.broadcast();

  BluetoothPrinterConnector(
      {required this.address, required this.isBle, this.name}) {
    flutterPrinterChannel.setMethodCallHandler((MethodCall call) {
      _methodStreamController.add(call);
      return Future(() => null);
    });
  }

  String address;
  String? name;
  bool isBle;
  BTStatus _status = BTStatus.none;

  BTStatus get status => _status;

  StreamController<String> devices = StreamController.broadcast();

  setAddress(String address) => this.address = address;

  setName(String name) => this.name = name;

  setIsBle(bool isBle) => this.isBle = isBle;

  static DiscoverResult<BluetoothPrinterDevice> discoverPrinters(
      {bool isBle = false}) async {
    if (Platform.isAndroid) {
      final List<dynamic> results = isBle
          ? await flutterPrinterChannel.invokeMethod('getBluetoothLeList')
          : await flutterPrinterChannel.invokeMethod('getBluetoothList');
      return results
          .map((dynamic r) => PrinterDiscovered<BluetoothPrinterDevice>(
                name: r['name'],
                detail: BluetoothPrinterDevice(
                  address: r['address'],
                ),
              ))
          .toList();
    }
    return [];
  }

  Stream<PrinterDevice> discovery({
    bool isBle = false,
    Duration? timeout = const Duration(seconds: 7),
  }) async* {
    final killStreams = <Stream>[];
    killStreams.add(_stopScanPill);
    killStreams.add(Rx.timer(null, timeout!));
    // Clear scan results list
    _scanResults.add(<PrinterDevice>[]);

    if (Platform.isAndroid) {
      isBle
          ? flutterPrinterChannel.invokeMethod('getBluetoothLeList')
          : flutterPrinterChannel.invokeMethod('getBluetoothList');

      await for (dynamic data in _methodStream
          .where((m) => m.method == "ScanResult")
          .map((m) => m.arguments)
          .takeUntil(Rx.merge(killStreams))
          // .takeUntil(TimerStream(3, Duration(seconds: 5)))
          .doOnDone(stopScan)
          .map((message) => message)) {
        var device = PrinterDevice(
            name: data['name'] as String, address: data['address'] as String?);
        if (!_addDevice(device)) continue;
        yield device;
      }
    } else if (Platform.isIOS) {
      try {
        await iosChannel.invokeMethod('startScan');
      } catch (e) {
        debugPrint('Error starting scan.');
        _stopScanPill.add(null);
        _isScanning.add(false);
        rethrow;
      }

      await for (dynamic data in _methodStream
          .where((m) => m.method == "ScanResult")
          .map((m) => m.arguments)
          .takeUntil(Rx.merge(killStreams))
          .doOnDone(stopScan)
          .map((message) => message)) {
        debugPrint('Scan result: $data');
        final device = PrinterDevice(
            name: data['name'] as String, address: data['address'] as String?);
        if (!_addDevice(device)) continue;
        yield device;
      }
    }
  }

  bool _addDevice(PrinterDevice device) {
    bool isDeviceAdded = true;
    final list = _scanResults.value;
    if (!list.any((e) => e.address == device.address)) {
      list.add(device);
    } else {
      isDeviceAdded = false;
    }
    _scanResults.add(list);
    return isDeviceAdded;
  }


  Future stopScan() async {
    if (Platform.isIOS) await iosChannel.invokeMethod('stopScan');
    _stopScanPill.add(null);
    _isScanning.add(false);
  }

  Future<bool> _connect({BluetoothPrinterInput? model}) async {
    if (Platform.isAndroid) {
      Map<String, dynamic> params = {
        "address": model?.address ?? address,
        "isBle": model?.isBle ?? isBle,
        "autoConnect": model?.autoConnect ?? false
      };
      return await flutterPrinterChannel.invokeMethod(
          'onStartConnection', params);
    } else if (Platform.isIOS) {
      Map<String, dynamic> params = {
        "name": model?.name ?? name,
        "address": model?.address ?? address
      };
      return await iosChannel.invokeMethod('connect', params);
    }
    return false;
  }

  Stream<BTStatus> get currentStatus async* {
    yield* _statusStream.cast<BTStatus>();
  }

  @override
  Future<bool> disconnect({int? delayMs}) async {
    if (Platform.isAndroid) {
      await flutterPrinterChannel.invokeMethod('disconnect');
    } else if (Platform.isIOS) {
      await iosChannel.invokeMethod('disconnect');
    }
    return false;
  }

  Future<dynamic> destroy() => iosChannel.invokeMethod('destroy');

  @override
  Future<bool> send(List<int> bytes) async {
    try {
      if (Platform.isAndroid) {
        Map<String, dynamic> params = {"bytes": bytes};
        return await flutterPrinterChannel.invokeMethod('sendDataByte', params);
      } else if (Platform.isIOS) {
        Map<String, Object> args = {};
        args['bytes'] = bytes;
        args['length'] = bytes.length;
        iosChannel.invokeMethod('writeData', args);
        return Future.value(true);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> connect(BluetoothPrinterInput model) async {
    try {
      return await _connect(model: model);
    } catch (e) {
      return false;
    }
  }
}
