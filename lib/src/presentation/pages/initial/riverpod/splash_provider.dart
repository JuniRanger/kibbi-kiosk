import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/dependency_manager.dart';
import 'splash_notifier.dart';
import 'splash_state.dart';

final splashProvider = StateNotifierProvider<SplashNotifier, SplashState>(
  (ref) => SplashNotifier(settingsRepository),
);
