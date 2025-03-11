import 'package:get_it/get_it.dart';
import '../../repository/repository.dart';
import '../handlers/handlers.dart';

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerSingleton<AuthFacade>(AuthRepository());
  getIt.registerSingleton<ProductsFacade>(ProductsRepository());
  getIt.registerSingleton<CategoriesRepository>(CategoriesRepositoryImpl());
  // getIt.registerSingleton<PaymentsRepository>(PaymentsRepositoryImpl());
  getIt.registerSingleton<OrdersRepository>(OrdersRepositoryImpl());
}

final dioHttp = getIt.get<HttpService>();
final authRepository = getIt.get<AuthFacade>();
final productsRepository = getIt.get<ProductsFacade>();
final categoriesRepository = getIt.get<CategoriesRepository>();
// final paymentsRepository = getIt.get<PaymentsRepository>();
final ordersRepository = getIt.get<OrdersRepository>();
