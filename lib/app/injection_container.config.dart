// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i7;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/remote_data_sources/items_remote_data_source.dart' as _i16;
import '../data/remote_data_sources/product_remote_data_source.dart' as _i19;
import '../data/remote_data_sources/purchased_product_remote_data_source.dart'
    as _i20;
import '../data/remote_data_sources/recipes_product_remote_data_source.dart'
    as _i21;
import '../data/remote_data_sources/recipes_remote_data_source.dart' as _i22;
import '../data/remote_data_sources/storage_remote_data_source.dart' as _i25;
import '../data/remote_data_sources/user_remote_data_source.dart' as _i27;
import 'cubit/auth_cubit.dart' as _i39;
import 'cubit/verification_cubit.dart' as _i29;
import 'home/home_page.dart' as _i15;
import 'home/pages/calendar/addShopping/add_page.dart' as _i8;
import 'home/pages/calendar/addShopping/cubit/add_cubit.dart' as _i37;
import 'home/pages/calendar/calendar.dart' as _i24;
import 'home/pages/calendar/cubit/shopping_cubit.dart' as _i40;
import 'home/pages/recipes/cubit/recipes_cubit.dart' as _i42;
import 'home/pages/recipes/recipes.dart' as _i12;
import 'home/pages/shop_list/cubit/add_product_cubit.dart' as _i38;
import 'home/pages/shop_list/cubit/product_cubit.dart' as _i41;
import 'home/pages/shop_list/shop_list/add_button_widget.dart' as _i3;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog/elevated_button_add_to_storage_widget.dart'
    as _i14;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog_widget.dart'
    as _i9;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product_widget.dart'
    as _i11;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible_widget.dart'
    as _i18;
import 'home/pages/shop_list/shop_list/list_of_product_group_widget.dart'
    as _i17;
import 'home/pages/your_products/cubit/purchased_products_cubit.dart' as _i36;
import 'home/pages/your_products/purchased_products/purchased_products.dart'
    as _i5;
import 'models/product_model.dart' as _i10;
import 'models/purchased_product_model.dart' as _i6;
import 'models/recipes_model.dart' as _i13;
import 'my_app.dart' as _i23;
import 'repositories/firebase_auth_repository.dart' as _i30;
import 'repositories/items_repository.dart' as _i31;
import 'repositories/product_repository.dart' as _i32;
import 'repositories/purchased_products_repository.dart' as _i33;
import 'repositories/recipes_products_repository.dart' as _i34;
import 'repositories/recipes_repository.dart' as _i35;
import 'repositories/storage_repository.dart' as _i26;
import 'repositories/user_repository.dart'
    as _i28; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AddButtonWidget>(() => _i3.AddButtonWidget(
        productGroup: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i5.AddDateWidget>(() => _i5.AddDateWidget(
        purchasedProductsModel: get<_i6.PurchasedProductModel>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i8.AddPage>(() => _i8.AddPage(key: get<_i4.Key>()));
  gh.factory<_i5.AddPurchasedProductWidget>(() => _i5.AddPurchasedProductWidget(
        storageNames: get<String>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i9.AddToStorageAlertDialogWidget>(
      () => _i9.AddToStorageAlertDialogWidget(
            key: get<_i4.Key>(),
            productModel: get<_i10.ProductModel>(),
          ));
  gh.factory<_i11.ChangeQuantityAlertDialog>(
      () => _i11.ChangeQuantityAlertDialog(
            key: get<_i4.Key>(),
            productModel: get<_i10.ProductModel>(),
          ));
  gh.factory<_i5.DeleteDateElevatedButton>(() => _i5.DeleteDateElevatedButton(
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
        isDated: get<bool>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i12.DeleteRecipesWidget>(() => _i12.DeleteRecipesWidget(
        key: get<_i4.Key>(),
        recipesModel: get<_i13.RecipesModel>(),
      ));
  gh.factory<_i14.ElevatedButtonAddToStorageWidget>(
      () => _i14.ElevatedButtonAddToStorageWidget(
            key: get<_i4.Key>(),
            storageName: get<String>(),
            productModel: get<_i10.ProductModel>(),
            productQuantity: get<int>(),
            isDated: get<bool>(),
            productTypeName: get<String>(),
            productPortion: get<int>(),
          ));
  gh.factory<_i15.HomePage>(() => _i15.HomePage(key: get<_i4.Key>()));
  gh.factory<_i16.ItemsRemoteDataSource>(() => _i16.ItemsRemoteDataSource());
  gh.factory<_i17.ListOfProductsGroupWidget>(
      () => _i17.ListOfProductsGroupWidget(key: get<_i4.Key>()));
  gh.factory<_i15.PersonButtonWidget>(
      () => _i15.PersonButtonWidget(key: get<_i4.Key>()));
  gh.factory<_i18.ProductDismissibleWidget>(() => _i18.ProductDismissibleWidget(
        key: get<_i4.Key>(),
        categoriesName: get<String>(),
      ));
  gh.factory<_i19.ProductRemoteDataSource>(
      () => _i19.ProductRemoteDataSource());
  gh.factory<_i20.PurchasedProductsRemoteDataSource>(
      () => _i20.PurchasedProductsRemoteDataSource());
  gh.factory<_i12.RecipesPage>(() => _i12.RecipesPage(key: get<_i4.Key>()));
  gh.factory<_i21.RecipesProductRemoteDataSource>(
      () => _i21.RecipesProductRemoteDataSource());
  gh.factory<_i22.RecipesRemoteDataSource>(
      () => _i22.RecipesRemoteDataSource());
  gh.factory<_i23.RootPage>(() => _i23.RootPage(key: get<_i4.Key>()));
  gh.factory<_i24.ShoppingPage>(() => _i24.ShoppingPage(key: get<_i4.Key>()));
  gh.factory<_i25.StorageRemoteDataSource>(
      () => _i25.StorageRemoteDataSource());
  gh.factory<_i26.StorageRepository>(
      () => _i26.StorageRepository(get<_i25.StorageRemoteDataSource>()));
  gh.factory<_i5.UpdateProductQuantityGram>(() => _i5.UpdateProductQuantityGram(
        key: get<_i7.Key>(),
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
      ));
  gh.factory<_i27.UserRemoteDataSource>(() => _i27.UserRemoteDataSource());
  gh.factory<_i28.UserRespository>(
      () => _i28.UserRespository(get<_i27.UserRemoteDataSource>()));
  gh.factory<_i29.VerificationCubit>(
      () => _i29.VerificationCubit(get<_i27.UserRemoteDataSource>()));

  gh.factory<_i30.FirebaseAuthRespository>(
      () => _i30.FirebaseAuthRespository(get<_i27.UserRemoteDataSource>()));
  gh.factory<_i31.ItemsRepository>(() => _i31.ItemsRepository(
        get<_i16.ItemsRemoteDataSource>(),
        get<_i27.UserRemoteDataSource>(),
      ));
  gh.factory<_i32.ProductsRepository>(() => _i32.ProductsRepository(
        get<_i19.ProductRemoteDataSource>(),
        get<_i27.UserRemoteDataSource>(),
      ));
  gh.factory<_i33.PurchasedProductsRepository>(
      () => _i33.PurchasedProductsRepository(
            get<_i20.PurchasedProductsRemoteDataSource>(),
            get<_i27.UserRemoteDataSource>(),
          ));
  gh.factory<_i34.RecipesProductsRepository>(
      () => _i34.RecipesProductsRepository(
            get<_i21.RecipesProductRemoteDataSource>(),
            get<_i27.UserRemoteDataSource>(),
          ));
  gh.factory<_i35.RecipesRepository>(() => _i35.RecipesRepository(
        get<_i22.RecipesRemoteDataSource>(),
        get<_i27.UserRemoteDataSource>(),
      ));
  gh.factory<_i36.YourProductsCubit>(
      () => _i36.YourProductsCubit(get<_i33.PurchasedProductsRepository>()));
  gh.factory<_i37.AddCubit>(() => _i37.AddCubit(get<_i31.ItemsRepository>()));
  gh.factory<_i38.AddProductCubit>(
      () => _i38.AddProductCubit(get<_i32.ProductsRepository>()));
  gh.factory<_i39.AuthCubit>(() => _i39.AuthCubit(
        get<_i30.FirebaseAuthRespository>(),
        get<_i27.UserRemoteDataSource>(),
      ));
  gh.factory<_i40.HomeCubit>(() => _i40.HomeCubit(get<_i31.ItemsRepository>()));
  gh.factory<_i41.ProductCubit>(
      () => _i41.ProductCubit(get<_i32.ProductsRepository>()));
  gh.factory<_i42.RecipesCubit>(() => _i42.RecipesCubit(
        get<_i35.RecipesRepository>(),
        get<_i28.UserRespository>(),
        get<_i25.StorageRemoteDataSource>(),
      ));
  return get;
}
