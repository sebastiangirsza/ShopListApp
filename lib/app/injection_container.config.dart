// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i7;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/remote_data_sources/product_price_remote_data_source.dart'
    as _i20;
import '../data/remote_data_sources/product_remote_data_source.dart' as _i21;
import '../data/remote_data_sources/purchased_product_remote_data_source.dart'
    as _i24;
import '../data/remote_data_sources/recipes_product_remote_data_source.dart'
    as _i25;
import '../data/remote_data_sources/recipes_remote_data_source.dart' as _i26;
import '../data/remote_data_sources/shop_products_remote_data_source.dart'
    as _i30;
import '../data/remote_data_sources/shop_remote_data_source.dart' as _i31;
import '../data/remote_data_sources/storage_remote_data_source.dart' as _i32;
import '../data/remote_data_sources/svg_icon_remote_data_source.dart' as _i34;
import '../data/remote_data_sources/user_remote_data_source.dart' as _i37;
import 'cubit/auth_cubit.dart' as _i54;
import 'cubit/verification_cubit.dart' as _i39;
import 'home/home_page.dart' as _i17;
import 'home/pages/price/product_price/widgets/shop_products/cubit/shop_products_cubit.dart'
    as _i59;
import 'home/pages/price/product_price/widgets/shop_products/product_price/cubit/product_price_cubit.dart'
    as _i56;
import 'home/pages/price/product_price/widgets/shop_products/product_price/product_price.dart'
    as _i22;
import 'home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/cubit/update_product_price_cubit.dart'
    as _i48;
import 'home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/widgets/update_product_button.dart'
    as _i36;
import 'home/pages/price/product_price/widgets/shop_products/shop_products_list.dart'
    as _i29;
import 'home/pages/price/product_price/widgets/title_and_elevated_button/add_shop_products/cubit/add_shop_product_cubit.dart'
    as _i53;
import 'home/pages/price/product_price/widgets/title_and_elevated_button/add_shop_products/widgets/add_shop_product_button.dart'
    as _i10;
import 'home/pages/price/shops/add_shop/cubit/add_shop_cubit.dart' as _i52;
import 'home/pages/price/shops/add_shop/widgets/add_shop_button.dart' as _i9;
import 'home/pages/price/shops/cubit/shop_cubit.dart' as _i58;
import 'home/pages/price/shops/shop_page.dart' as _i28;
import 'home/pages/recipes/cubit/recipes_cubit.dart' as _i57;
import 'home/pages/recipes/pages/add_recipes/add_recipes.dart' as _i8;
import 'home/pages/recipes/pages/add_recipes/cubit/add_recipes_cubit.dart'
    as _i51;
import 'home/pages/recipes/recipes.dart' as _i14;
import 'home/pages/shop_list/cubit/add_product_cubit.dart' as _i50;
import 'home/pages/shop_list/cubit/product_cubit.dart' as _i55;
import 'home/pages/shop_list/shop_list/list_of_product_group/add_button_widget.dart'
    as _i3;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog/elevated_button_add_to_storage_widget.dart'
    as _i16;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog_widget.dart'
    as _i11;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product_widget.dart'
    as _i13;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible_widget.dart'
    as _i19;
import 'home/pages/shop_list/shop_list/list_of_product_group_widget.dart'
    as _i18;
import 'home/pages/your_products/cubit/purchased_products_cubit.dart' as _i49;
import 'home/pages/your_products/purchased_products/purchased_products.dart'
    as _i5;
import 'models/product_model.dart' as _i12;
import 'models/purchased_product_model.dart' as _i6;
import 'models/recipes_model.dart' as _i15;
import 'models/shop_products_model.dart' as _i23;
import 'my_app.dart' as _i27;
import 'repositories/firebase_auth_repository.dart' as _i40;
import 'repositories/product_price_repository.dart' as _i41;
import 'repositories/product_repository.dart' as _i42;
import 'repositories/purchased_products_repository.dart' as _i43;
import 'repositories/recipes_products_repository.dart' as _i44;
import 'repositories/recipes_repository.dart' as _i45;
import 'repositories/shop_products_repository.dart' as _i46;
import 'repositories/shop_repository.dart' as _i47;
import 'repositories/storage_repository.dart' as _i33;
import 'repositories/svg_icon_repository.dart' as _i35;
import 'repositories/user_repository.dart'
    as _i38; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i10.AddShopProductButton>(() => _i10.AddShopProductButton(
        shopProductName: get<String>(),
        productGroup: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i11.AddToStorageAlertDialogWidget>(
      () => _i11.AddToStorageAlertDialogWidget(
            key: get<_i4.Key>(),
            productModel: get<_i12.ProductModel>(),
          ));
  gh.factory<_i13.ChangeQuantityAlertDialog>(
      () => _i13.ChangeQuantityAlertDialog(
            key: get<_i4.Key>(),
            productModel: get<_i12.ProductModel>(),
          ));
  gh.factory<_i5.DeleteDateElevatedButton>(() => _i5.DeleteDateElevatedButton(
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
        isDated: get<bool>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i14.DeleteRecipesWidget>(() => _i14.DeleteRecipesWidget(
        key: get<_i4.Key>(),
        recipesModel: get<_i15.RecipesModel>(),
      ));
  gh.factory<_i16.ElevatedButtonAddToStorageWidget>(
      () => _i16.ElevatedButtonAddToStorageWidget(
            key: get<_i4.Key>(),
            storageName: get<String>(),
            productModel: get<_i12.ProductModel>(),
            productQuantity: get<int>(),
            isDated: get<bool>(),
            productTypeName: get<String>(),
            productPortion: get<int>(),
          ));
  gh.factory<_i17.HomePage>(() => _i17.HomePage(key: get<_i4.Key>()));
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
  gh.factory<_i17.PersonButtonWidget>(
      () => _i17.PersonButtonWidget(key: get<_i4.Key>()));
  gh.factory<_i19.ProductDismissibleWidget>(() => _i19.ProductDismissibleWidget(
        key: get<_i4.Key>(),
        categoriesName: get<String>(),
      ));
  gh.factory<_i20.ProductPriceRemoteDataSource>(
      () => _i20.ProductPriceRemoteDataSource());
  gh.factory<_i21.ProductRemoteDataSource>(
      () => _i21.ProductRemoteDataSource());
  gh.factory<_i22.ProductsPrice>(() => _i22.ProductsPrice(
        key: get<_i4.Key>(),
        shopProductModel: get<_i23.ShopProductsModel>(),
      ));
  gh.factory<_i24.PurchasedProductsRemoteDataSource>(
      () => _i24.PurchasedProductsRemoteDataSource());
  gh.factory<_i14.RecipesPage>(() => _i14.RecipesPage(key: get<_i4.Key>()));
  gh.factory<_i25.RecipesProductRemoteDataSource>(
      () => _i25.RecipesProductRemoteDataSource());
  gh.factory<_i26.RecipesRemoteDataSource>(
      () => _i26.RecipesRemoteDataSource());
  gh.factory<_i27.RootPage>(() => _i27.RootPage(key: get<_i4.Key>()));
  gh.factory<_i28.ShopPage>(() => _i28.ShopPage(key: get<_i4.Key>()));
  gh.factory<_i29.ShopProductsList>(
      () => _i29.ShopProductsList(key: get<_i4.Key>()));
  gh.factory<_i30.ShopProductsRemoteDataSource>(
      () => _i30.ShopProductsRemoteDataSource());
  gh.factory<_i31.ShopRemoteDataSource>(() => _i31.ShopRemoteDataSource());
  gh.factory<_i17.SignOutButton>(() => _i17.SignOutButton(key: get<_i4.Key>()));
  gh.factory<_i32.StorageRemoteDataSource>(
      () => _i32.StorageRemoteDataSource());
  gh.factory<_i33.StorageRepository>(
      () => _i33.StorageRepository(get<_i32.StorageRemoteDataSource>()));
  gh.factory<_i34.SvgIconRemoteDataSource>(
      () => _i34.SvgIconRemoteDataSource());
  gh.factory<_i35.SvgIconRepository>(
      () => _i35.SvgIconRepository(get<_i34.SvgIconRemoteDataSource>()));
  gh.factory<_i36.UpdateProductButton>(() => _i36.UpdateProductButton(
        productPrice: get<double>(),
        id: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i5.UpdateProductQuantityGram>(() => _i5.UpdateProductQuantityGram(
        key: get<_i7.Key>(),
        purchasedProductModel: get<_i6.PurchasedProductModel>(),
      ));
  gh.factory<_i5.UpdateStorageWidget>(() => _i5.UpdateStorageWidget(
        key: get<_i7.Key>(),
        widget: get<_i5.OneProduct>(),
      ));
  gh.factory<_i37.UserRemoteDataSource>(() => _i37.UserRemoteDataSource());
  gh.factory<_i38.UserRepository>(
      () => _i38.UserRepository(get<_i37.UserRemoteDataSource>()));
  gh.factory<_i39.VerificationCubit>(
      () => _i39.VerificationCubit(get<_i37.UserRemoteDataSource>()));
  gh.factory<_i40.FirebaseAuthRespository>(
      () => _i40.FirebaseAuthRespository(get<_i37.UserRemoteDataSource>()));
  gh.factory<_i41.ProductPriceRepository>(() => _i41.ProductPriceRepository(
        get<_i20.ProductPriceRemoteDataSource>(),
        get<_i37.UserRemoteDataSource>(),
      ));
  gh.factory<_i42.ProductsRepository>(() => _i42.ProductsRepository(
        get<_i21.ProductRemoteDataSource>(),
        get<_i37.UserRemoteDataSource>(),
      ));
  gh.factory<_i43.PurchasedProductsRepository>(
      () => _i43.PurchasedProductsRepository(
            get<_i24.PurchasedProductsRemoteDataSource>(),
            get<_i37.UserRemoteDataSource>(),
          ));
  gh.factory<_i44.RecipesProductsRepository>(
      () => _i44.RecipesProductsRepository(
            get<_i25.RecipesProductRemoteDataSource>(),
            get<_i37.UserRemoteDataSource>(),
          ));
  gh.factory<_i45.RecipesRepository>(() => _i45.RecipesRepository(
        get<_i26.RecipesRemoteDataSource>(),
        get<_i37.UserRemoteDataSource>(),
      ));
  gh.factory<_i46.ShopProductsRepository>(() => _i46.ShopProductsRepository(
        get<_i30.ShopProductsRemoteDataSource>(),
        get<_i37.UserRemoteDataSource>(),
      ));
  gh.factory<_i47.ShopRepository>(() => _i47.ShopRepository(
        get<_i31.ShopRemoteDataSource>(),
        get<_i37.UserRemoteDataSource>(),
      ));
  gh.factory<_i48.UpdateProductPriceCubit>(
      () => _i48.UpdateProductPriceCubit(get<_i41.ProductPriceRepository>()));
  gh.factory<_i49.YourProductsCubit>(
      () => _i49.YourProductsCubit(get<_i43.PurchasedProductsRepository>()));
  gh.factory<_i50.AddProductCubit>(() => _i50.AddProductCubit(
        get<_i42.ProductsRepository>(),
        get<_i46.ShopProductsRepository>(),
      ));
  gh.factory<_i51.AddRecipesCubit>(() => _i51.AddRecipesCubit(
        get<_i45.RecipesRepository>(),
        get<_i38.UserRepository>(),
        get<_i33.StorageRepository>(),
      ));
  gh.factory<_i52.AddShopCubit>(() => _i52.AddShopCubit(
        get<_i38.UserRepository>(),
        get<_i32.StorageRemoteDataSource>(),
        get<_i33.StorageRepository>(),
        get<_i47.ShopRepository>(),
        get<_i46.ShopProductsRepository>(),
      ));
  gh.factory<_i53.AddShopProductsCubit>(() => _i53.AddShopProductsCubit(
        get<_i47.ShopRepository>(),
        get<_i46.ShopProductsRepository>(),
        get<_i41.ProductPriceRepository>(),
      ));
  gh.factory<_i54.AuthCubit>(() => _i54.AuthCubit(
        get<_i40.FirebaseAuthRespository>(),
        get<_i37.UserRemoteDataSource>(),
      ));
  gh.factory<_i55.ProductCubit>(
      () => _i55.ProductCubit(get<_i42.ProductsRepository>()));
  gh.factory<_i56.ProductPriceCubit>(
      () => _i56.ProductPriceCubit(get<_i41.ProductPriceRepository>()));
  gh.factory<_i57.RecipesCubit>(() => _i57.RecipesCubit(
        get<_i45.RecipesRepository>(),
        get<_i38.UserRepository>(),
        get<_i32.StorageRemoteDataSource>(),
      ));
  gh.factory<_i58.ShopCubit>(() => _i58.ShopCubit(get<_i47.ShopRepository>()));
  gh.factory<_i59.ShopProductsCubit>(() => _i59.ShopProductsCubit(
        get<_i46.ShopProductsRepository>(),
        get<_i35.SvgIconRepository>(),
      ));
  return get;
}
