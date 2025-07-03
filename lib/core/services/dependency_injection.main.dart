part of 'dependency_injection.dart';

final sl = GetIt.instance;

/// Injectiing Dependencies

Future<void> init() async {
  await dotenv.load();
  await _initApiClient();
  await _initLocalStorage();
  await _initBanner();
  await _initCategories();
  await _initProduct();
  await _initTheme();
}

// Setup ApiClient
Future<void> _initApiClient() async {
  sl.registerLazySingleton(() => const ApiService(baseUrl: ApiConst.baseUrl));
}

// Inject Local Storage instance
Future<void> _initLocalStorage() async {
  await Hive.initFlutter();
}

/// Feature --> Product
Future<void> _initProduct() async {
  sl
    ..registerFactory(() => ProductBloc(storeProduct: sl()))
    ..registerFactory(() => ProductProvider(getProducts: sl()))
    ..registerFactory(() => ProductCreateProvider(storeProduct: sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => StoreProduct(sl()))
    ..registerLazySingleton<ProductRepo>(() => ProductRepoImpl(sl()))
    ..registerLazySingleton<ProductRemoteDataSrc>(
      () => ProductRemoteDataSrcImpl(sl()),
    );
}

/// Feature --> Categories
Future<void> _initCategories() async {
  sl
    ..registerLazySingleton<CategoryRemoteDataSrc>(
      () => CategoryRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(sl()))
    ..registerLazySingleton<GetCategories>(() => GetCategories(sl()))
    ..registerSingleton<CategoryProvider>(
      CategoryProvider(getCategories: sl()),
    );
}

/// Feature --> Product
Future<void> _initBanner() async {
  sl
    ..registerFactory(() => BannerProvider(getBanners: sl()))
    ..registerLazySingleton(() => GetBanners(sl()))
    ..registerLazySingleton<BannerRepo>(() => BannerRepoImpl(sl()))
    ..registerLazySingleton<BannerRemoteDataSrc>(
      () => BannerRemoteDataSrcImpl(sl()),
    );
}

/// Feature --> Theme
Future<void> _initTheme() async {
  final themeBox = await Hive.openBox<dynamic>(StorageConst.themeBox);

  sl
    ..registerFactory(
      () => ThemeProvider(cacheThemeMode: sl(), loadThemeMode: sl()),
    )
    ..registerLazySingleton(() => CacheThemeMode(sl()))
    ..registerLazySingleton(() => LoadThemeMode(sl()))
    ..registerLazySingleton<ThemeRepo>(() => ThemeRepoImpl(sl()))
    ..registerLazySingleton<ThemeLocalDataSrc>(
      () => ThemeLocalDataSrcImpl(themeBox: themeBox),
    );
}
