import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'right_side_notifier.dart';
import 'right_side_state.dart';

final rightSideProvider =
    StateNotifierProvider<RightSideNotifier, RightSideState>(
  (ref) => RightSideNotifier(),
);
