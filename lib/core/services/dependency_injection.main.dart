part of 'dependency_injection.dart';

final GetIt sl = GetIt.instance;

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
  sl.registerLazySingleton(() => ApiService(baseUrl: ApiConst.baseUrl));
}

// Inject Local Storage instance
Future<void> _initLocalStorage() async {
  await Hive.initFlutter();
}

/// Feature --> Product
Future<void> _initProduct() async {
  sl
    ..registerFactory(
      () => ProductBloc(
        getProducts: sl(),
        storeProduct: sl(),
        updateProduct: sl(),
        deleteProduct: sl(),
      ),
    )
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => StoreProduct(sl()))
    ..registerLazySingleton(() => UpdateProduct(sl()))
    ..registerLazySingleton(() => DeleteProduct(sl()))
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
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => StoreCategory(sl()))
    ..registerLazySingleton(() => UpdateCategory(sl()))
    ..registerLazySingleton(() => DeleteCategory(sl()))
    ..registerFactory(
      () => CategoryBloc(storeCategory: sl(), updateCategory: sl()),
    )
    ..registerSingleton<CategoryProvider>(
      CategoryProvider(
        getCategories: sl<GetCategories>(),
        deleteCategory: sl<DeleteCategory>(),
      ),
    );
}

/// Feature --> Banners
Future<void> _initBanner() async {
  sl
    ..registerFactory(
      () => BannerBloc(
        getBanners: sl(),
        storeBanner: sl(),
        updateBanner: sl(),
        deleteBanner: sl(),
      ),
    )
    ..registerLazySingleton(() => GetBanners(sl()))
    ..registerLazySingleton(() => StoreBanner(sl()))
    ..registerLazySingleton(() => UpdateBanner(sl()))
    ..registerLazySingleton(() => DeleteBanner(sl()))
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
