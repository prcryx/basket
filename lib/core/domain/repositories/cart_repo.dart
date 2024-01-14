import 'package:mr_ambarisha_frontend_new/core/common/constants/api_constants.dart';
import 'package:mr_ambarisha_frontend_new/core/common/db/local_db.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/cart_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/cart_item_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_client.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_endpoint.dart';

abstract class CartRepository {
  Future<CartEntity?> getMyCart();
  Future<IntialCartItemEntity?> addToCart(String productId);
  Future<void> increaseQty(String productId);
  Future<void> decreaseQty(String productId);
  Future<Cart?> removeQty(String productId);
}

class CartRepositoryImpl extends CartRepository {
  final ApiClient apiClient;
  CartRepositoryImpl({required this.apiClient});

  @override
  Future<IntialCartItemEntity?> addToCart(String productId) async {
    String? accessToken = DatabaseBoxes.getAccessToken();
    final res = await apiClient.post(ApiEndpoints.addToCart, {
      "products": [
        {"productId": productId, "quantity": 1}
      ]
    }, overrideHeader: {
      ApiConstants.authorization: accessToken ?? ''
    });
    return IntialCartItemEntity.fromJson(res);
  }

  @override
  Future<void> increaseQty(String productId) async {
    String? accessToken = DatabaseBoxes.getAccessToken();
    await apiClient.put('${ApiEndpoints.increaseQtyCart}/$productId', {},
        overrideHeader: {ApiConstants.authorization: accessToken ?? ''});
  }

  @override
  Future<void> decreaseQty(String productId) async {
    String? accessToken = DatabaseBoxes.getAccessToken();
    await apiClient.put('${ApiEndpoints.decreaseQtyCart}/$productId', {},
        overrideHeader: {ApiConstants.authorization: accessToken ?? ''});
  }

  @override
  Future<Cart?> removeQty(String productId) async {
    String? accessToken = DatabaseBoxes.getAccessToken();

    final res = await apiClient.delete(
        '${ApiEndpoints.removeOneFromCart}/$productId', {},
        overrideHeader: {ApiConstants.authorization: accessToken ?? ''});
    return Cart.fromJson(res);
  }

  @override
  Future<CartEntity?> getMyCart() async {
    String? accessToken = DatabaseBoxes.getAccessToken();

    final res = await apiClient.get(ApiEndpoints.myCart,
        overrideHeader: {ApiConstants.authorization: accessToken ?? ''});
    return CartEntity.fromJson(res);
  }
}
