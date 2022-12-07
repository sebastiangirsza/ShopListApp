// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i7;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/remote_data_sources/items_remote_data_source.dart' as _i19;
import '../data/remote_data_sources/product_price_remote_data_source.dart'
    as _i22;
import '../data/remote_data_sources/product_remote_data_source.dart' as _i23;
import '../data/remote_data_sources/purchased_product_remote_data_source.dart'
    as _i26;
import '../data/remote_data_sources/recipes_product_remote_data_source.dart'
    as _i27;
import '../data/remote_data_sources/recipes_remote_data_source.dart' as _i28;
import '../data/remote_data_sources/shop_products_remote_data_source.dart'
    as _i32;
import '../data/remote_data_sources/shop_remote_data_source.dart' as _i33;
import '../data/remote_data_sources/storage_remote_data_source.dart' as _i34;
import '../data/remote_data_sources/user_remote_data_source.dart' as _i36;
import 'cubit/auth_cubit.dart' as _i54;
import 'cubit/verification_cubit.dart' as _i38;
import 'home/home_page.dart' as _i18;
import 'home/pages/price/add_product_price/cubit/add_product_price_cubit.dart'
    as _i50;
import 'home/pages/price/add_product_price/widgets/add_product_button.dart'
    as _i8;
import 'home/pages/price/add_shop/cubit/add_shop_cubit.dart' as _i52;
import 'home/pages/price/add_shop/widgets/add_shop_button.dart' as _i11;
import 'home/pages/price/add_shop_products/cubit/add_shop_product_cubit.dart'
    as _i53;
import 'home/pages/price/add_shop_products/widgets/add_shop_button.dart'
    as _i10;
import 'home/pages/price/product_price/cubit/product_price_cubit.dart' as _i56;
import 'home/pages/price/product_price/widgets/product_price.dart' as _i24;
import 'home/pages/price/product_price/widgets/shop_products/cubit/shop_products_cubit.dart'
    as _i59;
import 'home/pages/price/product_price/widgets/shop_products/shop_products_list.dart'
    as _i31;
import 'home/pages/price/shops/cubit/shop_cubit.dart' as _i58;
import 'home/pages/price/shops/shop_page.dart' as _i30;
import 'home/pages/recipes/cubit/recipes_cubit.dart' as _i57;
import 'home/pages/recipes/pages/add_recipes/add_recipes.dart' as _i9;
import 'home/pages/recipes/pages/add_recipes/cubit/add_recipes_cubit.dart'
    as _i51;
import 'home/pages/recipes/recipes.dart' as _i15;
import 'home/pages/shop_list/cubit/add_product_cubit.dart' as _i49;
import 'home/pages/shop_list/cubit/product_cubit.dart' as _i55;
import 'home/pages/shop_list/shop_list/add_button_widget.dart' as _i3;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog/elevated_button_add_to_storage_widget.dart'
    as _i17;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog_widget.dart'
    as _i12;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product_widget.dart'
    as _i14;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible_widget.dart'
    as _i21;
import 'home/pages/shop_list/shop_list/list_of_product_group_widget.dart'
    as _i20;
import 'home/pages/your_products/cubit/purchased_products_cubit.dart' as _i48;
import 'home/pages/your_products/purchased_products/purchased_products.dart'
    as _i5;
import 'models/product_model.dart' as _i13;
import 'models/purchased_product_model.dart' as _i6;
import 'models/recipes_model.dart' as _i16;
import 'models/shop_products_model.dart' as _i25;
import 'my_app.dart' as _i29;
import 'repositories/firebase_auth_repository.dart' as _i39;
import 'repositories/items_repository.dart' as _i40;
import 'repositories/product_price_repository.dart' as _i41;
import 'repositories/product_repository.dart' as _i42;
import 'repositories/purchased_products_repository.dart' as _i43;
import 'repositories/recipes_products_repository.dart' as _i44;
import 'repositories/recipes_repository.dart' as _i45;
import 'repositories/shop_products_repository.dart' as _i46;
import 'repositories/shop_repository.dart' as _i47;
import 'repositories/storage_repository.dart' as _i35;
import 'repositories/user_repository.dart'
    as _i37; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.AddProductButton>(() => _i8.AddProductButton(
        productPrice: get<double>(),
        id: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i5.AddPurchasedProductWidget>(() => _i5.AddPurchasedProductWidget(
        storageNames: get<String>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i9.AddRecipesWidget>(
      () => _i9.AddRecipesWidget(key: get<_i4.Key>()));
  gh.factory<_i10.AddShopButton>(() => _i10.AddShopButton(
        shopProductName: get<String>(),
        imageName: get<String>(),
        imagePath: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i11.AddShopButton>(() => _i11.AddShopButton(
        shopName: get<String>(),
        imageName: get<String>(),
        imagePath: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i12.AddToStorageAlertDialogWidget>(
      () => _i12.AddToStorageAlertDialogWidget(
            key: get<_i4.Key>(),
            productModel: get<_i13.ProductModel>(),
          ));
  gh.factory<_i14.ChangeQuantityAlertDialog>(
      () => _i14.ChangeQuantityAlertDialog(
            key: get<_i4.Key>(),
            productModel: get<_i13.ProductModel>(),
          ));
  gh.factory<_i5.DeleteDateElevatedButton>(() => _i5.DeleteDateElevatedButton(
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
        isDated: get<bool>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i15.DeleteRecipesWidget>(() => _i15.DeleteRecipesWidget(
        key: get<_i4.Key>(),
        recipesModel: get<_i16.RecipesModel>(),
      ));
  gh.factory<_i17.ElevatedButtonAddToStorageWidget>(
      () => _i17.ElevatedButtonAddToStorageWidget(
            key: get<_i4.Key>(),
            storageName: get<String>(),
            productModel: get<_i13.ProductModel>(),
            productQuantity: get<int>(),
            isDated: get<bool>(),
            productTypeName: get<String>(),
            productPortion: get<int>(),
          ));
  gh.factory<_i18.HomePage>(() => _i18.HomePage(key: get<_i4.Key>()));
  gh.factory<_i19.ItemsRemoteDataSource>(() => _i19.ItemsRemoteDataSource());
  gh.factory<_i20.ListOfProductsGroupWidget>(
      () => _i20.ListOfProductsGroupWidget(key: get<_i4.Key>()));
  gh.factory<_i5.Lists>(() => _i5.Lists(
        key: get<_i7.Key>(),
        storageName: get<String>(),
      ));
  gh.factory<_i5.OneProduct>(() => _i5.OneProduct(
        key: get<_i7.Key>(),
        purchasedProductsModel: get<_i6.PurchasedProductModel>(),
      ));
  gh.factory<_i18.PersonButtonWidget>(
      () => _i18.PersonButtonWidget(key: get<_i4.Key>()));
  gh.factory<_i21.ProductDismissibleWidget>(() => _i21.ProductDismissibleWidget(
        key: get<_i4.Key>(),
        categoriesName: get<String>(),
      ));
  gh.factory<_i22.ProductPriceRemoteDataSource>(
      () => _i22.ProductPriceRemoteDataSource());
  gh.factory<_i23.ProductRemoteDataSource>(
      () => _i23.ProductRemoteDataSource());
  gh.factory<_i24.ProductsPrice>(() => _i24.ProductsPrice(
        key: get<_i4.Key>(),
        shopProductModel: get<_i25.ShopProductsModel>(),
      ));
  gh.factory<_i26.PurchasedProductsRemoteDataSource>(
      () => _i26.PurchasedProductsRemoteDataSource());
  gh.factory<_i15.RecipesPage>(() => _i15.RecipesPage(key: get<_i4.Key>()));
  gh.factory<_i27.RecipesProductRemoteDataSource>(
      () => _i27.RecipesProductRemoteDataSource());
  gh.factory<_i28.RecipesRemoteDataSource>(
      () => _i28.RecipesRemoteDataSource());
  gh.factory<_i29.RootPage>(() => _i29.RootPage(key: get<_i4.Key>()));
  gh.factory<_i30.ShopPage>(() => _i30.ShopPage(key: get<_i4.Key>()));
  gh.factory<_i31.ShopProductsList>(
      () => _i31.ShopProductsList(key: get<_i4.Key>()));
  gh.factory<_i32.ShopProductsRemoteDataSource>(
      () => _i32.ShopProductsRemoteDataSource());
  gh.factory<_i33.ShopRemoteDataSource>(() => _i33.ShopRemoteDataSource());
  gh.factory<_i18.SignOutButton>(() => _i18.SignOutButton(key: get<_i4.Key>()));
  gh.factory<_i34.StorageRemoteDataSource>(
      () => _i34.StorageRemoteDataSource());
  gh.factory<_i35.StorageRepository>(
      () => _i35.StorageRepository(get<_i34.StorageRemoteDataSource>()));
  gh.factory<_i5.UpdateProductQuantityGram>(() => _i5.UpdateProductQuantityGram(
        key: get<_i7.Key>(),
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
      ));
  gh.factory<_i5.UpdateStorageWidget>(() => _i5.UpdateStorageWidget(
        key: get<_i7.Key>(),
        widget: get<_i5.OneProduct>(),
      ));
  gh.factory<_i36.UserRemoteDataSource>(() => _i36.UserRemoteDataSource());
  gh.factory<_i37.UserRespository>(
      () => _i37.UserRespository(get<_i36.UserRemoteDataSource>()));
  gh.factory<_i38.VerificationCubit>(
      () => _i38.VerificationCubit(get<_i36.UserRemoteDataSource>()));
  gh.factory<_i39.FirebaseAuthRespository>(
      () => _i39.FirebaseAuthRespository(get<_i36.UserRemoteDataSource>()));
  gh.factory<_i40.ItemsRepository>(() => _i40.ItemsRepository(
        get<_i19.ItemsRemoteDataSource>(),
        get<_i36.UserRemoteDataSource>(),
      ));
  gh.factory<_i41.ProductPriceRepository>(() => _i41.ProductPriceRepository(
        get<_i22.ProductPriceRemoteDataSource>(),
        get<_i36.UserRemoteDataSource>(),
      ));
  gh.factory<_i42.ProductsRepository>(() => _i42.ProductsRepository(
        get<_i23.ProductRemoteDataSource>(),
        get<_i36.UserRemoteDataSource>(),
      ));
  gh.factory<_i43.PurchasedProductsRepository>(
      () => _i43.PurchasedProductsRepository(
            get<_i26.PurchasedProductsRemoteDataSource>(),
            get<_i36.UserRemoteDataSource>(),
          ));
  gh.factory<_i44.RecipesProductsRepository>(
      () => _i44.RecipesProductsRepository(
            get<_i27.RecipesProductRemoteDataSource>(),
            get<_i36.UserRemoteDataSource>(),
          ));
  gh.factory<_i45.RecipesRepository>(() => _i45.RecipesRepository(
        get<_i28.RecipesRemoteDataSource>(),
        get<_i36.UserRemoteDataSource>(),
      ));
  gh.factory<_i46.ShopProductsRepository>(() => _i46.ShopProductsRepository(
        get<_i32.ShopProductsRemoteDataSource>(),
        get<_i36.UserRemoteDataSource>(),
      ));
  gh.factory<_i47.ShopRepository>(() => _i47.ShopRepository(
        get<_i33.ShopRemoteDataSource>(),
        get<_i36.UserRemoteDataSource>(),
      ));
  gh.factory<_i48.YourProductsCubit>(
      () => _i48.YourProductsCubit(get<_i43.PurchasedProductsRepository>()));
  gh.factory<_i49.AddProductCubit>(
      () => _i49.AddProductCubit(get<_i42.ProductsRepository>()));
  gh.factory<_i50.AddProductPriceCubit>(
      () => _i50.AddProductPriceCubit(get<_i41.ProductPriceRepository>()));
  gh.factory<_i51.AddRecipesCubit>(() => _i51.AddRecipesCubit(
        get<_i45.RecipesRepository>(),
        get<_i37.UserRespository>(),
        get<_i35.StorageRepository>(),
      ));
  gh.factory<_i52.AddShopCubit>(() => _i52.AddShopCubit(
        get<_i37.UserRespository>(),
        get<_i34.StorageRemoteDataSource>(),
        get<_i35.StorageRepository>(),
        get<_i47.ShopRepository>(),
        get<_i46.ShopProductsRepository>(),
      ));
  gh.factory<_i53.AddShopProductsCubit>(() => _i53.AddShopProductsCubit(
        get<_i37.UserRespository>(),
        get<_i34.StorageRemoteDataSource>(),
        get<_i35.StorageRepository>(),
        get<_i46.ShopProductsRepository>(),
        get<_i41.ProductPriceRepository>(),
        get<_i47.ShopRepository>(),
      ));
  gh.factory<_i54.AuthCubit>(() => _i54.AuthCubit(
        get<_i39.FirebaseAuthRespository>(),
        get<_i36.UserRemoteDataSource>(),
      ));
  gh.factory<_i55.ProductCubit>(
      () => _i55.ProductCubit(get<_i42.ProductsRepository>()));
  gh.factory<_i56.ProductPriceCubit>(
      () => _i56.ProductPriceCubit(get<_i41.ProductPriceRepository>()));
  gh.factory<_i57.RecipesCubit>(() => _i57.RecipesCubit(
        get<_i45.RecipesRepository>(),
        get<_i37.UserRespository>(),
        get<_i34.StorageRemoteDataSource>(),
      ));
  gh.factory<_i58.ShopCubit>(() => _i58.ShopCubit(get<_i47.ShopRepository>()));
  gh.factory<_i59.ShopProductsCubit>(
      () => _i59.ShopProductsCubit(get<_i46.ShopProductsRepository>()));
  return get;
}
