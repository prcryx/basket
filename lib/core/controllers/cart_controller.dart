import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/cart_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/cart_item_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/cart_repo.dart';

class CartController extends GetxController {
  CartRepository repo;
  CartController({required this.repo});

  Rx<CartEntity?> rxCart = Rx(null);
  Rx<CartSummary?> rxCartSummary = Rx(null);
  Rx<Cart?> rxCartItem = Rx(null);
  Rx<IntialCartItemEntity?> initCartItem = Rx(null);
  Rx<bool> rxIsLoading = false.obs;

  @override
  void onReady() async {
    await getMyCart();
    super.onReady();
  }

  void increaseOps(productId) {
    if (rxCartItem.value?.sId == null) {
      _addToCart(productId);
    } else {
      int ix = rxCartItem.value!.cartPoduct!.indexWhere(
          (product) => product.cartProductDetails!.sId == productId);
      if (ix != -1) {
        _increaseQty(productId);
      } else {
        _addToCart(productId);
      }
    }
  }

  void decreaseOps(productId) {
    // rxIsLoading.value = true;
    if (rxCartItem.value?.cartPoduct == null ||
        rxCartItem.value!.cartPoduct!.isEmpty) {
      return;
    } else {
      CartProduct? product;
      int ix = rxCartItem.value!.cartPoduct!.indexWhere(
          (product) => product.cartProductDetails!.sId == productId);
      if (ix != -1) {
        product = rxCartItem.value!.cartPoduct![ix];
      }
      if (product?.quantity == null) {
        return;
      }
      if (product?.quantity != null && product!.quantity! >= 2) {
        _decreaseQty(productId);
      } else if (0 < product!.quantity! && product.quantity! < 2) {
        _removeFromCart(productId);
      }
    }
    // rxIsLoading.value = false;
  }

  void _addToCart(String productId) async {
    try {
      await repo.addToCart(productId);
      await getMyCart();
      rxCartItem.refresh();
    } catch (e) {
      print("ERRRRRRRIRRRRRR========");
    }
  }

  void _increaseQty(productId) {
    try {
      repo.increaseQty(productId);
      int? index = rxCartItem.value?.cartPoduct?.indexWhere(
          (product) => product.cartProductDetails!.sId == productId);
      if (index != null && index != -1) {
        List<CartProduct> updatedList =
            List.from(rxCartItem.value!.cartPoduct!);
        var oldProduct = updatedList[index];
        var newQty = oldProduct.quantity! + 1;

        var updatedProduct = oldProduct.copyWith(qty: newQty);

        updatedList[index] = updatedProduct;
        rxCartItem.value!.cartPoduct = updatedList;
        rxCartItem.refresh();
      }
    } catch (e) {
      print("ERRROORRRRR =====>");
    }
  }

  void _decreaseQty(productId) {
    try {
      repo.decreaseQty(productId);
      int? index = rxCartItem.value?.cartPoduct?.indexWhere(
          (product) => product.cartProductDetails!.sId == productId);
      if (index != null && index != -1) {
        List<CartProduct> updatedList =
            List.from(rxCartItem.value!.cartPoduct!);
        var oldProduct = updatedList[index];
        var newQty = oldProduct.quantity! - 1;

        var updatedProduct = oldProduct.copyWith(qty: newQty);

        updatedList[index] = updatedProduct;
        rxCartItem.value!.cartPoduct = updatedList;
        rxCartItem.refresh();
      }
    } catch (e) {}
  }

  void _removeFromCart(productId) {
    try {
      repo.removeQty(productId);
      int? index = rxCartItem.value?.cartPoduct?.indexWhere(
          (product) => product.cartProductDetails!.sId == productId);
      if (index != null && index != -1) {
        rxCartItem.value!.cartPoduct?.removeAt(index);
      }
      rxCartItem.refresh();
    } catch (e) {
      print("FFFFFFFFFF");
    }
  }

  Future<void> getMyCart() async {
    rxCart.value = await repo.getMyCart();
    rxCartItem.value = rxCart.value?.cart;
    rxCartSummary.value = rxCart.value?.cartSummary;
    rxCartItem.refresh();
    rxCart.refresh();
  }
}
