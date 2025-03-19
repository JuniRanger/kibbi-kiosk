import 'package:kibbi_kiosk/src/models/data/product_data.dart';
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_state.dart';

class ProductService {
  final ShopState state;
  ProductService(this.state);

  // Método para obtener el nombre del producto según el productId
  String getProductName(String productId) {
    final product = state.allProducts.firstWhere(
      (p) => p.id == productId,
      orElse: () => ProductData(id: productId, name: 'Producto no encontrado'),
    );
    return product.name ?? 'Producto no encontrado';
  }

  // Método para obtener el precio de venta del producto según el productId
  num getProductSalePrice(String productId) {
    final product = state.allProducts.firstWhere(
      (p) => p.id == productId,
      orElse: () => ProductData(id: productId, salePrice: 0.0),
    );
    return product.salePrice ?? 0.0;
  }
}