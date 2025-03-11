import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../right_side/riverpod/right_side_notifier.dart';
import 'add_product_state.dart';

class AddProductNotifier extends StateNotifier<AddProductState> {
  AddProductNotifier() : super(const AddProductState());

  void setProduct(ProductData? product, int bagIndex) {
    state = state.copyWith(
      isLoading: false,
      product: product,
      stockCount: 0,
    );
  }

  void updateSelectedIndexes({
    required int index,
    required int value,
    required int bagIndex,
  }) {
    final newList = state.selectedIndexes.sublist(0, index);
    newList.add(value);
    final postList =
        List.filled(state.selectedIndexes.length - newList.length, 0);
    newList.addAll(postList);
    initialSetSelectedIndexes(newList, bagIndex);
  }

  void initialSetSelectedIndexes(List<int> indexes, int bagIndex) {
    state = state.copyWith(selectedIndexes: indexes);
    updateStock(bagIndex);
  }

  void updateStock(int bagIndex) {
    final Stocks? selectedStock = state.initialStocks.isNotEmpty
        ? state.initialStocks[0] // Assuming we're picking the first stock
        : null;
    final int minQty = state.product?.minQty ?? 0;
    final int selectedStockQty = selectedStock?.quantity ?? 0;
    final int stockCount =
        minQty <= selectedStockQty ? minQty : selectedStockQty;
    state = state.copyWith(
      selectedStock: selectedStock,
      stockCount: stockCount,
    );
  }

  void increaseStockCount(int bagIndex) {
    if ((state.selectedStock?.quantity ?? 0) < (state.product?.minQty ?? 0)) {
      return;
    }
    int newCount = state.stockCount;
    if (newCount >= (state.product?.maxQty ?? 100000) ||
        newCount >= (state.selectedStock?.quantity ?? 100000)) {
      return;
    } else if (newCount < (state.product?.minQty ?? 0)) {
      newCount = state.product?.minQty ?? 1;
      state = state.copyWith(stockCount: newCount);
    } else {
      newCount = newCount + 1;
      state = state.copyWith(stockCount: newCount);
    }
  }

  void decreaseStockCount(int bagIndex) {
    int newCount = state.stockCount;
    if (newCount <= 1) {
      return;
    } else if (newCount <= (state.product?.minQty ?? 0)) {
      newCount = (state.product?.minQty ?? 0);
      state = state.copyWith(stockCount: newCount);
    } else {
      newCount = newCount - 1;
      state = state.copyWith(stockCount: newCount);
    }
  }

  void addProductToBag(
    BuildContext context,
    int bagIndex,
    RightSideNotifier rightSideNotifier,
  ) {
    final List<BagProductData> bagProducts =
        LocalStorage.getBags()[bagIndex].bagProducts ?? [];

    int newStockIndex = -1;

    if (bagProducts.map((e) => e.stockId).contains(state.selectedStock?.id)) {
      for (int i = 0; i < bagProducts.length; i++) {
        if (bagProducts[i].stockId == state.selectedStock?.id) {
          newStockIndex = i;
          break;
        } else {
          newStockIndex = -1;
        }
      }
    }

    List<BagProductData> list = [];
    if (newStockIndex == -1) {
      bagProducts.insert(
        0,
        BagProductData(
            quantity: state.stockCount,
            carts: list),
      );
    } else {
      int oldCount = bagProducts[newStockIndex].quantity ?? 0;
      bagProducts.removeAt(newStockIndex);
      bagProducts.insert(
        newStockIndex,
        BagProductData(
            quantity: state.stockCount + oldCount,
            carts: list),
      );
    }

    List<BagData> bags = List.from(LocalStorage.getBags());
    bags[bagIndex] = bags[bagIndex].copyWith(bagProducts: bagProducts);
    LocalStorage.setBags(bags);

    rightSideNotifier.fetchCarts(context: context);
  }
}
