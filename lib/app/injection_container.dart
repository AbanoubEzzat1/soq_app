import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soq_app/app/app_prefs.dart';
import 'package:soq_app/data/data_source/remote_data_source.dart';
import 'package:soq_app/data/network/app_api.dart';
import 'package:soq_app/data/network/dio_factory.dart';
import 'package:soq_app/data/network/network_info.dart';
import 'package:soq_app/data/repository/repository_impl.dart';
import 'package:soq_app/domain/repository.dart';
import 'package:soq_app/domain/usecases/add_delete_cart_usecase.dart';
import 'package:soq_app/domain/usecases/add_delete_favorites_usecase.dart';
import 'package:soq_app/domain/usecases/cart_usecase.dart';
import 'package:soq_app/domain/usecases/favorites_usecase.dart';
import 'package:soq_app/domain/usecases/home_usecase.dart';
import 'package:soq_app/domain/usecases/login_usecase.dart';
import 'package:soq_app/domain/usecases/profile_usecase.dart';
import 'package:soq_app/domain/usecases/register_usecase.dart';

import '../data/data_source/local_data_source.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/search_usecase.dart';
import '../domain/usecases/update_profile_usecase.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module whare we put all generic di for all project

  //SharedPreferences instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //AppPreferences instance
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance<SharedPreferences>()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();

  //appServiseClient
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remoteDataSourse
  instance.registerLazySingleton<ReomteDataSource>(
      () => ReomteDataSourceImpl(instance()));
  //localDataSourse
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  //repository
  instance.registerFactory<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
  Repository repositorImpl = instance();
  instance.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<FavoritesUseCase>(
      () => FavoritesUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<AddOrDeleteFavoritesUseCase>(
      () => AddOrDeleteFavoritesUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<CartUseCase>(
      () => CartUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<AddOrDeleteCartUseCase>(
      () => AddOrDeleteCartUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<SearchUseCaase>(
      () => SearchUseCaase(repositorImpl as RepositoryImpl));
  instance.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(repositorImpl as RepositoryImpl));
}
