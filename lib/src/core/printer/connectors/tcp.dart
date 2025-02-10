import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

import '../discovery.dart';
import '../printer.dart';
import '../models/printer_device.dart';

class TcpPrinterInput extends BasePrinterInput {
  final String ipAddress;
  final int port;
  final Duration timeout;

  TcpPrinterInput({
    required this.ipAddress,
    this.port = 9100,
    this.timeout = const Duration(seconds: 5),
  });
}

class TcpPrinterInfo {
  String address;

  TcpPrinterInfo({required this.address});
}

class TcpPrinterConnector implements PrinterConnector<TcpPrinterInput> {
  TcpPrinterConnector._();

  static final TcpPrinterConnector _instance = TcpPrinterConnector._();

  static TcpPrinterConnector get instance => _instance;

  TcpPrinterConnector();

  Socket? _socket;

  static Future<List<PrinterDiscovered<TcpPrinterInfo>>> discoverPrinters(
      {String? ipAddress, int? port, Duration? timeOut}) async {
    final List<PrinterDiscovered<TcpPrinterInfo>> result = [];
    final defaultPort = port ?? 9100;

    String? deviceIp;
    if (Platform.isAndroid || Platform.isIOS) {
      deviceIp = await NetworkInfo().getWifiIP();
    } else if (ipAddress != null) {
      deviceIp = ipAddress;
    }
    if (deviceIp == null) return result;

    final String subnet = deviceIp.substring(0, deviceIp.lastIndexOf('.'));

    final stream = NetworkAnalyzer.discover2(
      subnet,
      defaultPort,
      timeout: timeOut ?? const Duration(milliseconds: 4000),
    );

    await for (var addr in stream) {
      if (addr.exists) {
        result.add(PrinterDiscovered<TcpPrinterInfo>(
            name: "${addr.ip}:$defaultPort",
            detail: TcpPrinterInfo(address: addr.ip)));
      }
    }

    return result;
  }

  Stream<PrinterDevice> discovery({TcpPrinterInput? model}) async* {
    final defaultPort = model?.port ?? 9100;

    String? deviceIp;
    if (Platform.isAndroid || Platform.isIOS) {
      deviceIp = await NetworkInfo().getWifiIP();
    } else if (model?.ipAddress != null) {
      deviceIp = model!.ipAddress;
    } else {
      return;
    }

    final String subnet = deviceIp!.substring(0, deviceIp.lastIndexOf('.'));
    final stream = NetworkAnalyzer.discover2(subnet, defaultPort);

    await for (var data in stream.map((message) => message)) {
      if (data.exists) {
        yield PrinterDevice(name: "${data.ip}:$defaultPort", address: data.ip);
      }
    }
  }

  @override
  Future<bool> send(List<int> bytes) async {
    try {
      _socket?.add(Uint8List.fromList(bytes));
      await _socket?.flush();
      _socket?.destroy();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> connect(TcpPrinterInput model) async {
    try {
      _socket = await Socket.connect(model.ipAddress, model.port,
          timeout: model.timeout);
      return true;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }

  @override
  Future<bool> disconnect({int? delayMs}) async {
    if (delayMs != null) {
      await Future.delayed(Duration(milliseconds: delayMs), () => null);
    }
    return true;
  }
}
