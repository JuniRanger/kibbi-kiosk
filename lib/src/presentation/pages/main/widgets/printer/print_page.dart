// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:kibbi_kiosk/src/core/printer/printer_help.dart';
import 'package:kibbi_kiosk/src/models/data/order_body_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/product_list/right_side/riverpod/right_side_provider.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/data/order_data.dart';
import '../../../../components/components.dart';
import 'printer/bluetooth_printer.dart';

class PrintPage extends ConsumerStatefulWidget {
  final OrderBodyData? orderData;

  const PrintPage({super.key, required this.orderData});

  @override
  ConsumerState<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends ConsumerState<PrintPage> {
  var defaultPrinterType = PrinterType.bluetooth;
  var _isBle = false;
  String customDivider = "-------------------------------------------";
  String customLine = "___________________________________________";
  String customSpace = "  ";
  var _reconnect = false;
  var printerManager = PrinterManager.instance;
  var devices = <BluetoothPrinter>[];
  StreamSubscription<PrinterDevice>? _subscription;
  StreamSubscription<BTStatus>? _subscriptionBtStatus;
  StreamSubscription<USBStatus>? _subscriptionUsbStatus;

  BTStatus _currentStatus = BTStatus.none;
  List<int>? pendingTask;
  String _ipAddress = '';
  String _port = '9100';
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  BluetoothPrinter? selectedPrinter;

  @override
  void initState() {
    if (Platform.isWindows) defaultPrinterType = PrinterType.usb;
    super.initState();
    _portController.text = _port;
    _scan();

    // subscription to listen change status of bluetooth connection
    _subscriptionBtStatus =
        PrinterManager.instance.stateBluetooth.listen((status) {
      log(' ----------------- status bt $status ------------------ ');
      _currentStatus = status;

      if (status == BTStatus.connected && pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.bluetooth, bytes: pendingTask!);
            pendingTask = null;
          });
        } else if (Platform.isIOS) {
          PrinterManager.instance
              .send(type: PrinterType.bluetooth, bytes: pendingTask!);
          pendingTask = null;
        }
      }
    });
    //  PrinterManager.instance.stateUSB is only supports on Android
    _subscriptionUsbStatus = PrinterManager.instance.stateUSB.listen((status) {
      log(' ----------------- status usb $status ------------------ ');
      if (Platform.isAndroid) {
        if (status == USBStatus.connected && pendingTask != null) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.usb, bytes: pendingTask!);
            pendingTask = null;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscriptionBtStatus?.cancel();
    _subscriptionUsbStatus?.cancel();

    _portController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  // method to scan devices according PrinterType
  void _scan() {
    devices.clear();
    _subscription = printerManager
        .discovery(type: defaultPrinterType, isBle: _isBle)
        .listen((device) {
      devices.add(BluetoothPrinter(
        deviceName: device.name,
        address: device.address,
        isBle: _isBle,
        vendorId: device.vendorId,
        productId: device.productId,
        typePrinter: defaultPrinterType,
      ));
      setState(() {});
    });
  }

  void setPort(String value) {
    if (value.isEmpty) value = '9100';
    _port = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  void setIpAddress(String value) {
    _ipAddress = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  void selectDevice(BluetoothPrinter device) async {
    if (selectedPrinter != null) {
      if ((device.address != selectedPrinter!.address) ||
          (device.typePrinter == PrinterType.usb &&
              selectedPrinter!.vendorId != device.vendorId)) {
        await PrinterManager.instance
            .disconnect(type: selectedPrinter!.typePrinter);
      }
    }

    selectedPrinter = device;
    setState(() {});
  }

  Future _printReceiveTest() async {
    final rightSideState = ref.watch(rightSideProvider);
    final bagData = rightSideState.bag;

    List<int> bytes = [];
    num subTotal = bagData?.cartTotal ?? 0; // Use cartTotal from BagData

    // Xprinter XP-N160I
    final profile = await CapabilityProfile.load(name: 'XP-N160I');

    // PaperSize.mm80 or PaperSize.mm58
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.setGlobalCodeTable('CP1252');
    bytes += generator.setStyles(const PosStyles(align: PosAlign.center));
    bytes += generator.text('Resumen del pedido',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.text(
        "Orden #${widget.orderData?.numOrder}",
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text(customDivider);
    bytes += generator.row([
      PosColumn(
          width: 7,
          text: '${customSpace}Restaurante',
          styles: const PosStyles(align: PosAlign.left, codeTable: 'CP1252')),
      PosColumn(
          width: 5,
          text: "Restaurante", // Replace with static text
          styles: const PosStyles(align: PosAlign.right, codeTable: 'CP1252')),
    ]);
    bytes += generator.row([
      PosColumn(
        width: 6,
        text: '${customSpace}Cliente',
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        width: 6,
        text: "Cliente", // Replace with static text
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        width: 6,
        text: '${customSpace}Fecha',
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        width: 6,
        text: DateFormat("MM/dd/yy HH:mm").format(DateTime.now()),
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.text(customLine);
    for (int index = 0; index < (bagData?.bagProducts?.length ?? 0); index++) {
      final product = bagData?.bagProducts?[index];
      bytes += generator.setStyles(const PosStyles(align: PosAlign.center));
      bytes += generator.row([
        PosColumn(
          width: 8,
          text: "$customSpace${product?.productId ?? ""} x ${product?.quantity ?? ""}",
          styles: const PosStyles(align: PosAlign.left, bold: true),
        ),
        PosColumn(
          width: 4,
          text: NumberFormat.currency(
            symbol: '\$',
          ).format((product?.quantity ?? 0) * 10), // Example price calculation
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
      ]);
      bytes += generator.setStyles(const PosStyles(align: PosAlign.center));
      bytes += generator.text(customDivider);
    }
    bytes += generator.text(customDivider);
    bytes += generator.row([
      PosColumn(
        width: 6,
        text: '${customSpace}Subtotal',
        styles: const PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        width: 6,
        text: AppHelpers.numberFormat(subTotal),
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        width: 6,
        text: '${customSpace}Precio total',
        styles: const PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        width: 6,
        text: AppHelpers.numberFormat(subTotal),
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]);
    bytes += generator.text(customDivider);
    bytes += generator.text('Gracias!!');

    _printEscPos(bytes, generator);
  }

  /// print ticket
  void _printEscPos(List<int> bytes, Generator generator) async {
    var connectedTCP = false;
    if (selectedPrinter == null) return;
    var bluetoothPrinter = selectedPrinter!;

    switch (bluetoothPrinter.typePrinter) {
      case PrinterType.usb:
        debugPrint("");
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: UsbPrinterInput(
                name: bluetoothPrinter.deviceName,
                productId: bluetoothPrinter.productId,
                vendorId: bluetoothPrinter.vendorId));
        pendingTask = null;
        break;
      case PrinterType.bluetooth:
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: BluetoothPrinterInput(
                name: bluetoothPrinter.deviceName,
                address: bluetoothPrinter.address!,
                isBle: bluetoothPrinter.isBle ?? false,
                autoConnect: _reconnect));
        pendingTask = null;
        if (Platform.isAndroid) pendingTask = bytes;
        break;
      case PrinterType.network:
        bytes += generator.feed(2);
        bytes += generator.cut();
        connectedTCP = await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: TcpPrinterInput(ipAddress: bluetoothPrinter.address!));
        if (!connectedTCP) debugPrint(' --- please review your connection ---');
        break;
      default:
    }
    if (bluetoothPrinter.typePrinter == PrinterType.bluetooth &&
        Platform.isAndroid) {
      if (_currentStatus == BTStatus.connected) {
        printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
        pendingTask = null;
      }
    } else {
      printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<PrinterType>(
            value: defaultPrinterType,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.print, size: 24),
              labelText: "Type Printer Device",
              labelStyle: TextStyle(fontSize: 18.0),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            items: <DropdownMenuItem<PrinterType>>[
              if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)
                const DropdownMenuItem(
                  value: PrinterType.bluetooth,
                  child: Text("bluetooth"),
                ),
              if (Platform.isAndroid || Platform.isWindows)
                const DropdownMenuItem(
                  value: PrinterType.usb,
                  child: Text("usb"),
                ),
              const DropdownMenuItem(
                value: PrinterType.network,
                child: Text("Wifi"),
              ),
            ],
            onChanged: (PrinterType? value) {
              setState(() {
                if (value != null) {
                  setState(() {
                    defaultPrinterType = value;
                    selectedPrinter = null;
                    _isBle = false;

                    _scan();
                  });
                }
              });
            },
          ),
          Visibility(
            visible: defaultPrinterType == PrinterType.bluetooth &&
                Platform.isAndroid,
            child: SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.only(bottom: 20.0, left: 20),
              title: const Text(
                "This device supports ble (low energy)",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 19.0),
              ),
              value: _isBle,
              onChanged: (bool? value) {
                setState(() {
                  _isBle = value ?? false;

                  selectedPrinter = null;
                  _scan();
                });
              },
            ),
          ),
          Visibility(
            visible: defaultPrinterType == PrinterType.bluetooth &&
                Platform.isAndroid,
            child: SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.only(bottom: 20.0, left: 20),
              title: const Text(
                "reconnect",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 19.0),
              ),
              value: _reconnect,
              onChanged: (bool? value) {
                setState(() {
                  _reconnect = value ?? false;
                });
              },
            ),
          ),
          Column(
              children: devices
                  .map(
                    (device) => ListTile(
                      title: Text('${device.deviceName}'),
                      subtitle: Platform.isAndroid &&
                              defaultPrinterType == PrinterType.usb
                          ? null
                          : Visibility(
                              visible: !Platform.isWindows,
                              child: Text("${device.address}")),
                      onTap: () => selectDevice(device),
                      leading: selectedPrinter != null &&
                              ((device.typePrinter == PrinterType.usb &&
                                          Platform.isWindows
                                      ? device.deviceName ==
                                          selectedPrinter!.deviceName
                                      : device.vendorId != null &&
                                          selectedPrinter!.vendorId ==
                                              device.vendorId) ||
                                  (device.address != null &&
                                      selectedPrinter!.address ==
                                          device.address))
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : null,
                      trailing: OutlinedButton(
                        onPressed: selectedPrinter == null ||
                                device.deviceName != selectedPrinter?.deviceName
                            ? null
                            : () async {
                                _printReceiveTest();
                              },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          child: Text("Print test ticket",
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  )
                  .toList()),
          Visibility(
            visible:
                defaultPrinterType == PrinterType.network && Platform.isWindows,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: _ipController,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                decoration: const InputDecoration(
                  label: Text("Ip Address"),
                  prefixIcon: Icon(Icons.wifi, size: 24),
                ),
                onChanged: setIpAddress,
              ),
            ),
          ),
          Visibility(
            visible:
                defaultPrinterType == PrinterType.network && Platform.isWindows,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: _portController,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                decoration: const InputDecoration(
                  label: Text("Port"),
                  prefixIcon: Icon(Icons.numbers_outlined, size: 24),
                ),
                onChanged: setPort,
              ),
            ),
          ),
          Visibility(
            visible:
                defaultPrinterType == PrinterType.network && Platform.isWindows,
            child: Padding(
              padding: REdgeInsets.only(top: 10),
              child: ConfirmButton(
                paddingSize: 32,
                onTap: () async {
                  _printReceiveTest();
                },
                title: "Print",
              ),
            ),
          )
        ],
      ),
    );
  }
}
