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
    as _i21;
import '../data/remote_data_sources/product_remote_data_source.dart' as _i22;
import '../data/remote_data_sources/purchased_product_remote_data_source.dart'
    as _i25;
import '../data/remote_data_sources/recipes_product_remote_data_source.dart'
    as _i26;
import '../data/remote_data_sources/recipes_remote_data_source.dart' as _i27;
import '../data/remote_data_sources/shop_products_remote_data_source.dart'
    as _i31;
import '../data/remote_data_sources/shop_remote_data_source.dart' as _i32;
import '../data/remote_data_sources/storage_remote_data_source.dart' as _i33;
import '../data/remote_data_sources/svg_icon_remote_data_source.dart' as _i35;
import '../data/remote_data_sources/user_remote_data_source.dart' as _i38;
import 'cubit/auth_cubit.dart' as _i55;
import 'cubit/verification_cubit.dart' as _i40;
import 'home/home_page.dart' as _i18;
import 'home/pages/price/product_price/widgets/shop_products/cubit/shop_products_cubit.dart'
    as _i60;
import 'home/pages/price/product_price/widgets/shop_products/product_price/cubit/product_price_cubit.dart'
    as _i57;
import 'home/pages/price/product_price/widgets/shop_products/product_price/product_price.dart'
    as _i23;
import 'home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/cubit/update_product_price_cubit.dart'
    as _i49;
import 'home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/widgets/update_product_button.dart'
    as _i37;
import 'home/pages/price/product_price/widgets/shop_products/shop_products_list.dart'
    as _i30;
import 'home/pages/price/product_price/widgets/title_and_elevated_button/add_shop_products/cubit/add_shop_product_cubit.dart'
    as _i54;
import 'home/pages/price/product_price/widgets/title_and_elevated_button/add_shop_products/widgets/add_shop_product_button.dart'
    as _i11;
import 'home/pages/price/shops/add_shop/cubit/add_shop_cubit.dart' as _i53;
import 'home/pages/price/shops/add_shop/widgets/add_shop_button.dart' as _i10;
import 'home/pages/price/shops/cubit/shop_cubit.dart' as _i59;
import 'home/pages/price/shops/shop_page.dart' as _i29;
import 'home/pages/recipes/cubit/recipes_cubit.dart' as _i58;
import 'home/pages/recipes/pages/add_recipes/add_recipes.dart' as _i9;
import 'home/pages/recipes/pages/add_recipes/cubit/add_recipes_cubit.dart'
    as _i52;
import 'home/pages/recipes/recipes.dart' as _i15;
import 'home/pages/shop_list/cubit/add_product_cubit.dart' as _i51;
import 'home/pages/shop_list/cubit/product_cubit.dart' as _i56;
import 'home/pages/shop_list/shop_list/add_product_from_list.dart' as _i8;
import 'home/pages/shop_list/shop_list/list_of_product_group/add_button_widget.dart'
    as _i3;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog/elevated_button_add_to_storage_widget.dart'
    as _i17;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog_widget.dart'
    as _i12;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product_widget.dart'
    as _i14;
import 'home/pages/shop_list/shop_list/list_of_product_group/products_dismissible_widget.dart'
    as _i20;
import 'home/pages/shop_list/shop_list/list_of_product_group_widget.dart'
    as _i19;
import 'home/pages/your_products/cubit/purchased_products_cubit.dart' as _i50;
import 'home/pages/your_products/purchased_products/purchased_products.dart'
    as _i5;
import 'models/product_model.dart' as _i13;
import 'models/purchased_product_model.dart' as _i6;
import 'models/recipes_model.dart' as _i16;
import 'models/shop_products_model.dart' as _i24;
import 'my_app.dart' as _i28;
import 'repositories/firebase_auth_repository.dart' as _i41;
import 'repositories/product_price_repository.dart' as _i42;
import 'repositories/product_repository.dart' as _i43;
import 'repositories/purchased_products_repository.dart' as _i44;
import 'repositories/recipes_products_repository.dart' as _i45;
import 'repositories/recipes_repository.dart' as _i46;
import 'repositories/shop_products_repository.dart' as _i47;
import 'repositories/shop_repository.dart' as _i48;
import 'repositories/storage_repository.dart' as _i34;
import 'repositories/svg_icon_repository.dart' as _i36;
import 'repositories/user_repository.dart'
    as _i39; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.AddProductFromList>(
      () => _i8.AddProductFromList(key: get<_i4.Key>()));
  gh.factory<_i5.AddPurchasedProductWidget>(() => _i5.AddPurchasedProductWidget(
        storageNames: get<String>(),
        key: get<_i7.Key>(),
      ));
  gh.factory<_i9.AddRecipesWidget>(
      () => _i9.AddRecipesWidget(key: get<_i4.Key>()));
  gh.factory<_i10.AddShopButton>(() => _i10.AddShopButton(
        shopName: get<String>(),
        imageName: get<String>(),
        imagePath: get<String>(),
        key: get<_i4.Key>(),
      ));
  gh.factory<_i11.AddShopProductButton>(() => _i11.AddShopProductButton(
        shopProductName: get<String>(),
        productGroup: get<String>(),
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
  gh.factory<_i19.ListOfProductsGroupWidget>(
      () => _i19.ListOfProductsGroupWidget(key: get<_i4.Key>()));
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
  gh.factory<_i20.ProductDismissibleWidget>(() => _i20.ProductDismissibleWidget(
        key: get<_i4.Key>(),
        categoriesName: get<String>(),
      ));
  gh.factory<_i21.ProductPriceRemoteDataSource>(
      () => _i21.ProductPriceRemoteDataSource());
  gh.factory<_i22.ProductRemoteDataSource>(
      () => _i22.ProductRemoteDataSource());
  gh.factory<_i23.ProductsPrice>(() => _i23.ProductsPrice(
        key: get<_i4.Key>(),
        shopProductModel: get<_i24.ShopProductsModel>(),
      ));
  gh.factory<_i25.PurchasedProductsRemoteDataSource>(
      () => _i25.PurchasedProductsRemoteDataSource());
  gh.factory<_i15.RecipesPage>(() => _i15.RecipesPage(key: get<_i4.Key>()));
  gh.factory<_i26.RecipesProductRemoteDataSource>(
      () => _i26.RecipesProductRemoteDataSource());
  gh.factory<_i27.RecipesRemoteDataSource>(
      () => _i27.RecipesRemoteDataSource());
  gh.factory<_i28.RootPage>(() => _i28.RootPage(key: get<_i4.Key>()));
  gh.factory<_i29.ShopPage>(() => _i29.ShopPage(key: get<_i4.Key>()));
  gh.factory<_i30.ShopProductsList>(
      () => _i30.ShopProductsList(key: get<_i4.Key>()));
  gh.factory<_i31.ShopProductsRemoteDataSource>(
      () => _i31.ShopProductsRemoteDataSource());
  gh.factory<_i32.ShopRemoteDataSource>(() => _i32.ShopRemoteDataSource());
  gh.factory<_i18.SignOutButton>(() => _i18.SignOutButton(key: get<_i4.Key>()));
  gh.factory<_i33.StorageRemoteDataSource>(
      () => _i33.StorageRemoteDataSource());
  gh.factory<_i34.StorageRepository>(
      () => _i34.StorageRepository(get<_i33.StorageRemoteDataSource>()));
  gh.factory<_i35.SvgIconRemoteDataSource>(
      () => _i35.SvgIconRemoteDataSource());
  gh.factory<_i36.SvgIconRepository>(
      () => _i36.SvgIconRepository(get<_i35.SvgIconRemoteDataSource>()));
  gh.factory<_i37.UpdateProductButton>(() => _i37.UpdateProductButton(
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
  gh.factory<_i38.UserRemoteDataSource>(() => _i38.UserRemoteDataSource());
  gh.factory<_i39.UserRepository>(
      () => _i39.UserRepository(get<_i38.UserRemoteDataSource>()));
  gh.factory<_i40.VerificationCubit>(
      () => _i40.VerificationCubit(get<_i38.UserRemoteDataSource>()));
  gh.factory<_i41.FirebaseAuthRespository>(
      () => _i41.FirebaseAuthRespository(get<_i38.UserRemoteDataSource>()));
  gh.factory<_i42.ProductPriceRepository>(() => _i42.ProductPriceRepository(
        get<_i21.ProductPriceRemoteDataSource>(),
        get<_i38.UserRemoteDataSource>(),
      ));
  gh.factory<_i43.ProductsRepository>(() => _i43.ProductsRepository(
        get<_i22.ProductRemoteDataSource>(),
        get<_i38.UserRemoteDataSource>(),
      ));
  gh.factory<_i44.PurchasedProductsRepository>(
      () => _i44.PurchasedProductsRepository(
            get<_i25.PurchasedProductsRemoteDataSource>(),
            get<_i38.UserRemoteDataSource>(),
          ));
  gh.factory<_i45.RecipesProductsRepository>(
      () => _i45.RecipesProductsRepository(
            get<_i26.RecipesProductRemoteDataSource>(),
            get<_i38.UserRemoteDataSource>(),
          ));
  gh.factory<_i46.RecipesRepository>(() => _i46.RecipesRepository(
        get<_i27.RecipesRemoteDataSource>(),
        get<_i38.UserRemoteDataSource>(),
      ));
  gh.factory<_i47.ShopProductsRepository>(() => _i47.ShopProductsRepository(
        get<_i31.ShopProductsRemoteDataSource>(),
        get<_i38.UserRemoteDataSource>(),
      ));
  gh.factory<_i48.ShopRepository>(() => _i48.ShopRepository(
        get<_i32.ShopRemoteDataSource>(),
        get<_i38.UserRemoteDataSource>(),
      ));
  gh.factory<_i49.UpdateProductPriceCubit>(
      () => _i49.UpdateProductPriceCubit(get<_i42.ProductPriceRepository>()));
  gh.factory<_i50.YourProductsCubit>(
      () => _i50.YourProductsCubit(get<_i44.PurchasedProductsRepository>()));
  gh.factory<_i51.AddProductCubit>(() => _i51.AddProductCubit(
        get<_i43.ProductsRepository>(),
        get<_i47.ShopProductsRepository>(),
      ));
  gh.factory<_i52.AddRecipesCubit>(() => _i52.AddRecipesCubit(
        get<_i46.RecipesRepository>(),
        get<_i39.UserRepository>(),
        get<_i34.StorageRepository>(),
      ));
  gh.factory<_i53.AddShopCubit>(() => _i53.AddShopCubit(
        get<_i39.UserRepository>(),
        get<_i33.StorageRemoteDataSource>(),
        get<_i34.StorageRepository>(),
        get<_i48.ShopRepository>(),
        get<_i47.ShopProductsRepository>(),
      ));
  gh.factory<_i54.AddShopProductsCubit>(() => _i54.AddShopProductsCubit(
        get<_i48.ShopRepository>(),
        get<_i47.ShopProductsRepository>(),
        get<_i42.ProductPriceRepository>(),
      ));
  gh.factory<_i55.AuthCubit>(() => _i55.AuthCubit(
        get<_i41.FirebaseAuthRespository>(),
        get<_i38.UserRemoteDataSource>(),
      ));
  gh.factory<_i56.ProductCubit>(
      () => _i56.ProductCubit(get<_i43.ProductsRepository>()));
  gh.factory<_i57.ProductPriceCubit>(
      () => _i57.ProductPriceCubit(get<_i42.ProductPriceRepository>()));
  gh.factory<_i58.RecipesCubit>(() => _i58.RecipesCubit(
        get<_i46.RecipesRepository>(),
        get<_i39.UserRepository>(),
        get<_i33.StorageRemoteDataSource>(),
      ));
  gh.factory<_i59.ShopCubit>(() => _i59.ShopCubit(get<_i48.ShopRepository>()));
  gh.factory<_i60.ShopProductsCubit>(() => _i60.ShopProductsCubit(
        get<_i47.ShopProductsRepository>(),
        get<_i36.SvgIconRepository>(),
      ));
  return get;
}
