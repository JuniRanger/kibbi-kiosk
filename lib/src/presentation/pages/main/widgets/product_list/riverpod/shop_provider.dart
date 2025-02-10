import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shop_notifier.dart';
import 'shop_state.dart';

final shopProvider = StateNotifierProvider<ShopNotifier, ShopState>(
  (ref) => ShopNotifier(),
);
