import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'help_notifier.dart';
import 'help_state.dart';

final helpProvider = StateNotifierProvider<HelpNotifier, HelpState>(
  (ref) => HelpNotifier(),
);
