import 'package:kiosk/src/repository/impl/orders_repository_impl.dart';
import 'package:kiosk/src/repository/impl/table_repository_iml.dart';
import 'package:kiosk/src/repository/orders.dart';
import 'package:get_it/get_it.dart';
import 'package:kiosk/src/repository/table.dart';
import '../../repository/impl/gallery_repository.dart';
import '../../repository/repository.dart';
import '../handlers/handlers.dart';

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerSingleton<SettingsFacade>(SettingsRepository());
  getIt.registerSingleton<AuthFacade>(AuthRepository());
  getIt.registerSingleton<ProductsFacade>(ProductsRepository());
  getIt.registerSingleton<ShopsRepository>(ShopsRepositoryImpl());
  getIt.registerSingleton<BrandsRepository>(BrandsRepositoryImpl());
  getIt.registerSingleton<GalleryRepositoryFacade>(GalleryRepository());
  getIt.registerSingleton<CategoriesRepository>(CategoriesRepositoryImpl());
  getIt.registerSingleton<PaymentsRepository>(PaymentsRepositoryImpl());
  getIt.registerSingleton<OrdersRepository>(OrdersRepositoryImpl());
  getIt.registerSingleton<UsersRepository>(UsersRepositoryImpl());
  getIt.registerSingleton<TableRepository>(TableRepositoryIml());
}

final dioHttp = getIt.get<HttpService>();
final settingsRepository = getIt.get<SettingsFacade>();
final authRepository = getIt.get<AuthFacade>();
final productsRepository = getIt.get<ProductsFacade>();
final shopsRepository = getIt.get<ShopsRepository>();
final brandsRepository = getIt.get<BrandsRepository>();
final galleryRepository = getIt.get<GalleryRepositoryFacade>();
final categoriesRepository = getIt.get<CategoriesRepository>();
final paymentsRepository = getIt.get<PaymentsRepository>();
final ordersRepository = getIt.get<OrdersRepository>();
final usersRepository = getIt.get<UsersRepository>();
final tableRepository = getIt.get<TableRepository>();
