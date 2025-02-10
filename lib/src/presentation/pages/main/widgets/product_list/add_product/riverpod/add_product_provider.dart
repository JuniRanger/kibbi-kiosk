import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_product_notifier.dart';
import 'add_product_state.dart';

final addProductProvider =
    StateNotifierProvider<AddProductNotifier, AddProductState>(
  (ref) => AddProductNotifier(),
);
