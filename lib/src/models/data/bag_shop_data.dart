import 'bag_data.dart';
import 'restaurant_data.dart';

class BagRestaurantData {
  final RestaurantData restaurantData;
  final List<BagProductData> bagProducts;

  BagRestaurantData({required this.restaurantData, required this.bagProducts});
}
