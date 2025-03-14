import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../right_side/riverpod/right_side_notifier.dart';
import 'add_product_state.dart';

class AddProductNotifier extends StateNotifier<AddProductState> {
  AddProductNotifier() : super(const AddProductState());

  void setProduct(ProductData? product) {
    state = state.copyWith(
      isLoading: false,
      product: product,
      stockCount: 1, // Se inicia con 0 como la cantidad seleccionada
    );
  }

  void updateSelectedIndexes({
    required int index,
    required int value,
  }) {
    final newList = state.selectedIndexes.sublist(0, index);
    newList.add(value);
    final postList =
        List.filled(state.selectedIndexes.length - newList.length, 0);
    newList.addAll(postList);
    initialSetSelectedIndexes(newList);
  }

  void initialSetSelectedIndexes(List<int> indexes) {
    state = state.copyWith(selectedIndexes: indexes);
    // Ya no necesitamos actualizar el stock
  }

  void increaseStockCount() {
    int newCount = state.stockCount;
    // Limitar a un mínimo de 1, si se desea
    if (newCount < 1) {
      newCount = 1;
    } else {
      newCount = newCount + 1; // Aumentar la cantidad seleccionada
    }
    state = state.copyWith(stockCount: newCount);
  }

  void decreaseStockCount() {
    int newCount = state.stockCount;
    if (newCount <= 1) {
      return; // No decrementamos más si la cantidad es 1 o menos
    } else {
      newCount = newCount - 1;
      state = state.copyWith(stockCount: newCount);
    }
  }

  void addProductToBag(
    BuildContext context,
    RightSideNotifier rightSideNotifier,
  ) {
    // Obtener la bolsa existente o crear una nueva si es nula
    BagData? bag = LocalStorage.getBag();
    if (bag == null) {
      debugPrint('No se encontró bolsa en LocalStorage, creando nueva bolsa');
      bag = BagData(bagProducts: []);
    }

    // Crear el nuevo producto para la bolsa
    final newBagProduct = BagProductData(
      productId: state.product?.id, // Usar el id del producto
      quantity: state.stockCount, // Usar la cantidad seleccionada en el carrito
    );

    // Obtener los productos actuales de la bolsa
    List<BagProductData> bagProducts = List.from(bag.bagProducts ?? []);

    // Buscar si el producto ya existe
    int existingIndex = bagProducts
        .indexWhere((product) => product.productId == state.product?.id);

    if (existingIndex != -1) {
      // Actualizar cantidad si el producto existe
      bagProducts[existingIndex] = BagProductData(
        productId: state.product?.id,
        quantity: (bagProducts[existingIndex].quantity ?? 0) + state.stockCount,
      );
    } else {
      // Agregar nuevo producto si no existe
      bagProducts.insert(0, newBagProduct);
    }

    // Actualizar la bolsa
    bag = bag.copyWith(bagProducts: bagProducts);

    // Guardar en LocalStorage
    LocalStorage.setBag(bag);

    // Actualizar el estado en RightSide
    rightSideNotifier
        ..fetchBag() // Actualiza la bolsa
        ..fetchCarts(context: context); // Actualiza el carrito
  }
}
