// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i7;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/remote_data_sources/items_remote_data_source.dart' as _i17;
import '../data/remote_data_sources/product_price_remote_data_source.dart'
    as _i22;
import '../data/remote_data_sources/product_remote_data_source.dart' as _i23;
import '../data/remote_data_sources/purchased_product_remote_data_source.dart'
    as _i24;
import '../data/remote_data_sources/recipes_product_remote_data_source.dart'
    as _i25;
import '../data/remote_data_sources/recipes_remote_data_source.dart' as _i26;
import '../data/remote_data_sources/shop_remote_data_source.dart' as _i29;
import '../data/remote_data_sources/storage_remote_data_source.dart' as _i30;
import '../data/remote_data_sources/user_remote_data_source.dart' as _i32;
import 'cubit/auth_cubit.dart' as _i48;
import 'cubit/verification_cubit.dart' as _i34;
import 'home/home_page.dart' as _i16;
import 'home/pages/price/add_product_price/cubit/add_product_price_cubit.dart'
    as _i45;
import 'home/pages/price/add_shop/add_shop_page.dart' as _i9;
import 'home/pages/price/add_shop/cubit/add_shop_cubit.dart' as _i47;
import 'home/pages/price/cubit/price_cubit.dart' as _i49;
import 'home/pages/price/price_page.dart' as _i19;
import 'home/pages/price/product_price/cubit/product_price_cubit.dart' as _i51;
import 'home/pages/price/product_price/product_price_page.dart' as _i21;
import 'home/pages/price/shop/cubit/shop_cubit.dart' as _i53;
import 'home/pages/price/shop/shop_page.dart' as _i28;
import 'home/pages/recipes/cubit/recipes_cubit.dart' as _i52;
import 'home/pages/recipes/pages/add_recipes/add_recipes.dart' as _i8;
import 'home/pages/recipes/pages/add_recipes/cubit/add_recipes_cubit.dart'
    as _i46;
import 'home/pages/recipes/recipes.dart' as _i13;
import 'home/pages/shop_list/cubit/add_product_cubit.dart' as _i44;
import 'home/pages/shop_list/cubit/product_cubit.dart' as _i50;
import 'home/pages/shop_list/shop_list/add_button_widget.dart' as _i3;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog/elevated_button_add_to_storage_widget.dart'
    as _i15;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog_widget.dart'
    as _i10;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product_widget.dart'
    as _i12;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible_widget.dart'
    as _i20;
import 'home/pages/shop_list/shop_list/list_of_product_group_widget.dart'
    as _i18;
import 'home/pages/your_products/cubit/purchased_products_cubit.dart' as _i43;
import 'home/pages/your_products/purchased_products/purchased_products.dart'
    as _i5;
import 'models/product_model.dart' as _i11;
import 'models/purchased_product_model.dart' as _i6;
import 'models/recipes_model.dart' as _i14;
import 'my_app.dart' as _i27;
import 'repositories/firebase_auth_repository.dart' as _i35;
import 'repositories/items_repository.dart' as _i36;
import 'repositories/product_price_repository.dart' as _i37;
import 'repositories/product_repository.dart' as _i38;
import 'repositories/purchased_products_repository.dart' as _i39;
import 'repositories/recipes_products_repository.dart' as _i40;
import 'repositories/recipes_repository.dart' as _i41;
import 'repositories/shop_repository.dart' as _i42;
import 'repositories/storage_repository.dart' as _i31;
import 'repositories/user_repository.dart'
    as _i33; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i5.AddPurchasedProductWidget>(() => _i5.AddPurchasedProductWidget(
        storageNames: get<String>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i8.AddRecipesWidget>(
      () => _i8.AddRecipesWidget(key: get<_i4.Key>()));
  gh.factory<_i9.AddShopButton>(() => _i9.AddShopButton(
        shopName: get<String>(),
        imageName: get<String>(),
        imagePath: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i9.AddShopPage>(() => _i9.AddShopPage(key: get<_i4.Key>()));
  gh.factory<_i10.AddToStorageAlertDialogWidget>(
      () => _i10.AddToStorageAlertDialogWidget(
            key: get<_i4.Key>(),
            productModel: get<_i11.ProductModel>(),
          ));
  gh.factory<_i12.ChangeQuantityAlertDialog>(
      () => _i12.ChangeQuantityAlertDialog(
            key: get<_i4.Key>(),
            productModel: get<_i11.ProductModel>(),
          ));
  gh.factory<_i5.DeleteDateElevatedButton>(() => _i5.DeleteDateElevatedButton(
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
        isDated: get<bool>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i13.DeleteRecipesWidget>(() => _i13.DeleteRecipesWidget(
        key: get<_i4.Key>(),
        recipesModel: get<_i14.RecipesModel>(),
      ));
  gh.factory<_i15.ElevatedButtonAddToStorageWidget>(
      () => _i15.ElevatedButtonAddToStorageWidget(
            key: get<_i4.Key>(),
            storageName: get<String>(),
            productModel: get<_i11.ProductModel>(),
            productQuantity: get<int>(),
            isDated: get<bool>(),
            productTypeName: get<String>(),
            productPortion: get<int>(),
          ));
  gh.factory<_i16.HomePage>(() => _i16.HomePage(key: get<_i4.Key>()));
  gh.factory<_i17.ItemsRemoteDataSource>(() => _i17.ItemsRemoteDataSource());
  gh.factory<_i18.ListOfProductsGroupWidget>(
      () => _i18.ListOfProductsGroupWidget(key: get<_i4.Key>()));
  gh.factory<_i5.Lists>(() => _i5.Lists(
        key: get<_i7.Key>(),
        storageName: get<String>(),
      ));
  gh.factory<_i5.OneProduct>(() => _i5.OneProduct(
        key: get<_i7.Key>(),
        purchasedProductsModel: get<_i6.PurchasedProductModel>(),
      ));
  gh.factory<_i16.PersonButtonWidget>(
      () => _i16.PersonButtonWidget(key: get<_i4.Key>()));
  gh.factory<_i19.PricePage>(() => _i19.PricePage(key: get<_i4.Key>()));
  gh.factory<_i20.ProductDismissibleWidget>(() => _i20.ProductDismissibleWidget(
        key: get<_i4.Key>(),
        categoriesName: get<String>(),
      ));
  gh.factory<_i21.ProductPricePage>(
      () => _i21.ProductPricePage(key: get<_i4.Key>()));
  gh.factory<_i22.ProductPriceRemoteDataSource>(
      () => _i22.ProductPriceRemoteDataSource());
  gh.factory<_i23.ProductRemoteDataSource>(
      () => _i23.ProductRemoteDataSource());
  gh.factory<_i24.PurchasedProductsRemoteDataSource>(
      () => _i24.PurchasedProductsRemoteDataSource());
  gh.factory<_i13.RecipesPage>(() => _i13.RecipesPage(key: get<_i4.Key>()));
  gh.factory<_i25.RecipesProductRemoteDataSource>(
      () => _i25.RecipesProductRemoteDataSource());
  gh.factory<_i26.RecipesRemoteDataSource>(
      () => _i26.RecipesRemoteDataSource());
  gh.factory<_i27.RootPage>(() => _i27.RootPage(key: get<_i4.Key>()));
  gh.factory<_i28.ShopPage>(() => _i28.ShopPage(key: get<_i4.Key>()));
  gh.factory<_i29.ShopRemoteDataSource>(() => _i29.ShopRemoteDataSource());
  gh.factory<_i16.SignOutButton>(() => _i16.SignOutButton(key: get<_i4.Key>()));
  gh.factory<_i30.StorageRemoteDataSource>(
      () => _i30.StorageRemoteDataSource());
  gh.factory<_i31.StorageRepository>(
      () => _i31.StorageRepository(get<_i30.StorageRemoteDataSource>()));
  gh.factory<_i5.UpdateProductQuantityGram>(() => _i5.UpdateProductQuantityGram(
        key: get<_i7.Key>(),
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
      ));
  gh.factory<_i5.UpdateStorageWidget>(() => _i5.UpdateStorageWidget(
        key: get<_i7.Key>(),
        widget: get<_i5.OneProduct>(),
      ));
  gh.factory<_i32.UserRemoteDataSource>(() => _i32.UserRemoteDataSource());
  gh.factory<_i33.UserRespository>(
      () => _i33.UserRespository(get<_i32.UserRemoteDataSource>()));
  gh.factory<_i34.VerificationCubit>(
      () => _i34.VerificationCubit(get<_i32.UserRemoteDataSource>()));
  gh.factory<_i35.FirebaseAuthRespository>(
      () => _i35.FirebaseAuthRespository(get<_i32.UserRemoteDataSource>()));
  gh.factory<_i36.ItemsRepository>(() => _i36.ItemsRepository(
        get<_i17.ItemsRemoteDataSource>(),
        get<_i32.UserRemoteDataSource>(),
      ));
  gh.factory<_i37.ProductPriceRepository>(() => _i37.ProductPriceRepository(
        get<_i22.ProductPriceRemoteDataSource>(),
        get<_i32.UserRemoteDataSource>(),
      ));
  gh.factory<_i38.ProductsRepository>(() => _i38.ProductsRepository(
        get<_i23.ProductRemoteDataSource>(),
        get<_i32.UserRemoteDataSource>(),
      ));
  gh.factory<_i39.PurchasedProductsRepository>(
      () => _i39.PurchasedProductsRepository(
            get<_i24.PurchasedProductsRemoteDataSource>(),
            get<_i32.UserRemoteDataSource>(),
          ));
  gh.factory<_i40.RecipesProductsRepository>(
      () => _i40.RecipesProductsRepository(
            get<_i25.RecipesProductRemoteDataSource>(),
            get<_i32.UserRemoteDataSource>(),
          ));
  gh.factory<_i41.RecipesRepository>(() => _i41.RecipesRepository(
        get<_i26.RecipesRemoteDataSource>(),
        get<_i32.UserRemoteDataSource>(),
      ));
  gh.factory<_i42.ShopRepository>(() => _i42.ShopRepository(
        get<_i29.ShopRemoteDataSource>(),
        get<_i32.UserRemoteDataSource>(),
      ));
  gh.factory<_i43.YourProductsCubit>(
      () => _i43.YourProductsCubit(get<_i39.PurchasedProductsRepository>()));
  gh.factory<_i44.AddProductCubit>(
      () => _i44.AddProductCubit(get<_i38.ProductsRepository>()));
  gh.factory<_i45.AddProductPriceCubit>(() => _i45.AddProductPriceCubit(
        get<_i37.ProductPriceRepository>(),
        get<_i33.UserRespository>(),
        get<_i31.StorageRepository>(),
        get<_i30.StorageRemoteDataSource>(),
      ));
  gh.factory<_i46.AddRecipesCubit>(() => _i46.AddRecipesCubit(
        get<_i41.RecipesRepository>(),
        get<_i33.UserRespository>(),
        get<_i31.StorageRepository>(),
      ));
  gh.factory<_i47.AddShopCubit>(() => _i47.AddShopCubit(
        get<_i33.UserRespository>(),
        get<_i30.StorageRemoteDataSource>(),
        get<_i31.StorageRepository>(),
        get<_i42.ShopRepository>(),
      ));
  gh.factory<_i48.AuthCubit>(() => _i48.AuthCubit(
        get<_i35.FirebaseAuthRespository>(),
        get<_i32.UserRemoteDataSource>(),
      ));
  gh.factory<_i49.PriceCubit>(
      () => _i49.PriceCubit(get<_i37.ProductPriceRepository>()));
  gh.factory<_i50.ProductCubit>(
      () => _i50.ProductCubit(get<_i38.ProductsRepository>()));
  gh.factory<_i51.ProductPriceCubit>(
      () => _i51.ProductPriceCubit(get<_i37.ProductPriceRepository>()));
  gh.factory<_i52.RecipesCubit>(() => _i52.RecipesCubit(
        get<_i41.RecipesRepository>(),
        get<_i33.UserRespository>(),
        get<_i30.StorageRemoteDataSource>(),
      ));
  gh.factory<_i53.ShopCubit>(() => _i53.ShopCubit(get<_i42.ShopRepository>()));
  return get;
}
