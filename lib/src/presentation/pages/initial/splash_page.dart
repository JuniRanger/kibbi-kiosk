import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod/splash_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => ref.read(splashProvider.notifier).fetchGlobalSettings(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Style.white,
      body: Loading(),
    );
  }
}
