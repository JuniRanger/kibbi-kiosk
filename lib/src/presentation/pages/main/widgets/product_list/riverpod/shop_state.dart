
import 'package:kibbi_kiosk/src/models/data/order_data.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState({
    @Default(false) bool isProductsLoading,
    @Default(false) bool isMoreProductsLoading,
    @Default(false) bool isBrandsLoading,
    @Default(false) bool isCategoriesLoading,
    @Default(true) bool hasMore,
    @Default([]) List<ProductData> products, 
    @Default([]) List<ProductData> allProducts, // Todos los productos cargados
    @Default([]) List<CategoryData> categories,
    @Default([]) List<DropDownItemData> dropDownCategories,
    @Default([]) List<DropDownItemData> dropDownBrands,
    @Default('') String query,
    @Default('') String categoryQuery,
    CategoryData? selectedCategory,
    OrderData? selectedOrder,
  }) = _ShopState;

  const ShopState._();
}