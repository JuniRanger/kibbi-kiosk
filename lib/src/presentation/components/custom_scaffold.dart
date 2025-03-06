import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../theme/theme/theme.dart';
import '../theme/theme/theme_warpper.dart';
import 'components.dart';


class CustomScaffold extends StatefulWidget {
  final Widget Function(CustomColorSet colors) body;
  final Widget? Function(CustomColorSet colors)? floatingActionButton;
  final Widget? Function(CustomColorSet colors)? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? Function(CustomColorSet colors)? appBar;
  final Color? backgroundColor;
  final bool bgImage;
  final bool extendBody;

  const CustomScaffold(
      {super.key,
      required this.body,
      this.appBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.backgroundColor,
      this.bottomNavigationBar,
      this.bgImage = false,
      this.extendBody = false})
     ;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold>
    with WidgetsBindingObserver {
  StreamSubscription? connectivitySubscription;
  ValueNotifier<bool> isNetworkDisabled = ValueNotifier(false);
  void _checkCurrentNetworkState() {
    Connectivity().checkConnectivity().then((connectivityResult) {
      isNetworkDisabled.value =
          connectivityResult.contains(ConnectivityResult.none);
    });
  }

  initStateFunc() {
    _checkCurrentNetworkState();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          (result) {
        isNetworkDisabled.value = result.contains(ConnectivityResult.none);
      },
    );
  }


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initStateFunc();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkCurrentNetworkState();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ThemeWrapper(builder: (colors, controller) {
          return KeyboardDismisser(
            child: Scaffold(
              extendBody: widget.extendBody,
              resizeToAvoidBottomInset: false,
              appBar: widget.appBar?.call(colors),
              backgroundColor: widget.backgroundColor ?? colors.backgroundColor,
              body: widget.body(colors),
              floatingActionButton: widget.floatingActionButton?.call(colors),
              floatingActionButtonLocation: widget.floatingActionButtonLocation,
              bottomNavigationBar: widget.bottomNavigationBar?.call(colors),
            ),
          );
        }),
        ValueListenableBuilder(
          valueListenable: isNetworkDisabled,
          builder: (_, bool networkDisabled, __) => Visibility(
            visible: networkDisabled,
            child: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
