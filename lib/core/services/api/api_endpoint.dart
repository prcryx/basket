abstract class ApiEndpoints {
  ApiEndpoints._();
  static const apiHostUrl = 'https://ambarisha-vercel.vercel.app/api/v1/';
  static const register = 'register';
  static const verifyRegisterOtp = 'verify/otp';
  static const login = 'login';
  static const veifyLoginOtp = 'verify/login';
  static const me = 'me';
  static const categories = 'category/all';
  static const myCart = 'cart';
  static const addToCart = 'cart/add';
  static const productByCategory= 'product/category';
  static const increaseQtyCart = 'cart/increase';
  static const decreaseQtyCart = 'cart/decrease';
  static const removeOneFromCart = 'cart/remove';
  static const removeAllFromCart = 'cart/remove/cart/all';
  static const applyCoupon = 'cart/applycoupon';
}
