// ignore_for_file: void_checks

import 'dart:ffi';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:soq_app/app/injection_container.dart';
import 'package:soq_app/data/data_source/local_data_source.dart';
import 'package:soq_app/domain/models.dart';
import 'package:soq_app/domain/usecases/add_delete_cart_usecase.dart';
import 'package:soq_app/domain/usecases/home_usecase.dart';
import 'package:soq_app/domain/usecases/logout_usecase.dart';
import 'package:soq_app/domain/usecases/profile_usecase.dart';
import 'package:soq_app/domain/usecases/update_profile_usecase.dart';
import 'package:soq_app/presentation/bloc/home_bloc/home_states.dart';
import '../../../app/app_prefs.dart';
import '../../../data/network/failure.dart';
import '../../../domain/usecases/add_delete_favorites_usecase.dart';
import '../../../domain/usecases/cart_usecase.dart';
import '../../../domain/usecases/favorites_usecase.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  final HomeUseCase _homeUseCase = instance<HomeUseCase>();
  final FavoritesUseCase _favoritesUseCase = instance<FavoritesUseCase>();
  final CartUseCase _cartUseCase = instance<CartUseCase>();
  final AddOrDeleteFavoritesUseCase _addOrDeleteFavoritesUseCase =
      instance<AddOrDeleteFavoritesUseCase>();
  final AddOrDeleteCartUseCase _addOrDeleteCartUseCase =
      instance<AddOrDeleteCartUseCase>();
  final ProfileUseCase _profileUseCase = instance<ProfileUseCase>();
  Authentication? authentication;
  final UpdateProfileUseCase _updateProfileUseCase =
      instance<UpdateProfileUseCase>();
  final LogoutUseCase _logoutUseCase = instance<LogoutUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  bool? isCartEmpty;
  CartModel? cartModel;
  List<CartProductModel>? cartProducts = [];
  Map<int, bool>? cart = {};

  Map<int, bool>? favorites = {};
  FavoritesModel? favoritesModel;
  bool? isFavoritesListEmpty;
  List<FavoritesDataModel>? favoritesDataModelList;
  Map<int, bool> favorits = {};

  HomeModel? homMeodel;

//-- Home
  Future getHome() async {
    emit(HomeLoadingState());
    Either<Failure, HomeModel> response = await _homeUseCase.execute(Void);
    emit(
      response.fold((failure) {
        if (kDebugMode) {
          print(failure.code);
        }
        if (kDebugMode) {
          print(failure.message);
        }
        return HomeErrorState(failure.message);
      }, (data) {
        homMeodel = data;
        for (var element in data.data!.products) {
          favorits.addAll({element.id: element.inFavorites});
          cart?.addAll({element.id: element.inCart});
        }
        return HomeSuccessState(data);
      }),
    );
  }

//-- Favorites
  getFavorites() async {
    emit(FavoritesLoadingState());
    Either<Failure, FavoritesModel> response =
        await _favoritesUseCase.execute(Void);
    emit(
      response.fold(
        (faliure) {
          if (kDebugMode) {
            print(faliure.code);
          }
          if (kDebugMode) {
            print(faliure.message);
          }
          return FavoritesErrorState(faliure.message);
        },
        (data) {
          favoritesModel = data;
          isFavoritesListEmpty = data.data!.data.isEmpty;
          favoritesDataModelList = data.data!.data.cast<FavoritesDataModel>();

          return FavoritesSuccessState(data);
        },
      ),
    );
  }

  addOrDeleteFavorites(int productId) async {
    favorits[productId] = !favorits[productId]!;
    emit(AddOrDeleteFavoritesLoadingState());
    Either<Failure, AddOrDeleteFavoritesModel> response =
        await _addOrDeleteFavoritesUseCase
            .execute(AddOrDeleteFavoritesUseCaseinputs(productId));
    emit(response.fold((failure) {
      if (kDebugMode) {
        print(failure.code);
      }
      if (kDebugMode) {
        print(failure.message);
      }
      favorits[productId] = !favorits[productId]!;
      return AddOrDeleteFavoritesErrorState(failure.message);
    }, (data) {
      getFavorites();
      return AddOrDeleteFavoritesSuccessState(data);
    }));
  }

//-- Cart
  getCart() async {
    emit(CartLoadingState());
    Either<Failure, CartModel> response = await _cartUseCase.execute(Void);
    emit(
      response.fold((failure) {
        if (kDebugMode) {
          print(failure.code);
        }
        if (kDebugMode) {
          print(failure.message);
        }
        return CartErrorState(failure.message);
      }, (data) {
        cartModel = data;
        isCartEmpty = data.data.cartItems.isEmpty;
        cartProducts = data.data.cartItems.cast<CartProductModel>();
        // ignore: avoid_function_literals_in_foreach_calls
        data.data.cartItems.forEach((element) {
          cart?.addAll({element.product!.id: element.product!.inCart});
          favorites?.addAll({element.id: element.product!.inFavorites});
        });

        return CartSuccessState(data);
      }),
    );
  }

  addOrDeleteCart(int productId) async {
    cart![productId] = !cart![productId]!;
    emit(AddOrDeleteCartLoadingState());
    var response = await _addOrDeleteCartUseCase
        .execute(AddOrDeleteCartUseCaseinputs(productId));
    emit(
      response.fold((failure) {
        if (kDebugMode) {
          print(failure.code);
        }
        if (kDebugMode) {
          print(failure.message);
        }
        cart![productId] = !cart![productId]!;
        return AddOrDeleteCartErrorState(failure.message);
      }, (data) {
        getCart();
        return AddOrDeleteCartSuccessState(data);
      }),
    );
  }

//-- Sittings
  AuthenticationData? authenticationData;
  getProfile() async {
    emit(ProfileLoadingState());
    Either<Failure, Authentication> response =
        await _profileUseCase.execute(Void);
    emit(response.fold((failure) {
      if (kDebugMode) {
        print(failure.code);
      }
      if (kDebugMode) {
        print(failure.message);
      }
      return ProfileErrorState(failure.message);
    }, (data) {
      if (data.data != null) {
        authenticationData = data.data;
      }
      return ProfileSuccessState(data);
    }));
  }

  updateProfile(
    String name,
    String email,
    String phone, {
    String password = "",
    String image =
        "https://firebasestorage.googleapis.com/v0/b/ecommerce-29ce0.appspot.com/o/businessman-character-avatar-isolated_24877-60111.webp?alt=media&token=7d0013ba-d679-4d7d-b12c-f9b21ce7e7f8",
  }) async {
    emit(UpdateProfileLoadingState());
    var response =
        await _updateProfileUseCase.execute(UpdateProfileUseCaseInputs(
      name,
      email,
      phone,
      password,
      image,
    ));
    emit(response.fold((failure) {
      if (kDebugMode) {
        print(failure.code);
      }
      if (kDebugMode) {
        print(failure.message);
      }
      return UpdateProfileErrorState(failure.message);
    }, (data) {
      getProfile();
      return UpdateProfileSuccessState(data);
    }));
  }

  //-- Logout
  logoutFun() {
    _appPreferences.removeToken().then((value) {
      _appPreferences.removeUserLoggedIn();
      _localDataSource.clearCache();
    });
  }

  LogoutModel? logoutModel;
  logout() async {
    String token = await _appPreferences.getUserToken();
    emit(LogoutLoadingState());
    Either<Failure, LogoutModel> response =
        await _logoutUseCase.execute(LogoutUseCaseInpouts(token));
    response.fold((failure) {
      if (kDebugMode) {
        print(failure.code);
      }
      if (kDebugMode) {
        print(failure.message);
      }
      emit(LogoutErrorState(failure.message));
    }, (data) async {
      logoutModel = data;
      await _appPreferences.removeUserLoggedIn();
      await _appPreferences.removeToken();
      _localDataSource.clearCache();

      emit(LogoutSuccessState(data));
    });
  }

  changeLanguage(context) {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
    emit(ChangeLanguageSuccessState());
  }
}
