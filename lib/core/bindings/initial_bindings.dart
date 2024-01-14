import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/auth_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/cart_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/category_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/product_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/profile_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/auth_repo.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/cart_repo.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/category_repo.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/product_repo.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/profile_repo.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_client.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    _services();
    _repositories();
    _controllers();
  }

  // ===== Services ======
  void _services() {
    Get.put<ApiClient>(ApiClient(), permanent: true);
  }

  // ====== Repositories ======
  void _repositories() {
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        apiClient: Get.find<ApiClient>(),
      ),
      permanent: true,
    );
    Get.put<ProfileRepository>(
      ProfileRepositoryImpl(
        apiClient: Get.find<ApiClient>(),
      ),
    );
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(
        apiClient: Get.find<ApiClient>(),
      ),
      fenix: true,
    );
    Get.lazyPut<CartRepository>(
      () => CartRepositoryImpl(
        apiClient: Get.find<ApiClient>(),
      ),
      fenix: true,
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        apiClient: Get.find<ApiClient>(),
      ),
      fenix: true,
    );
  }

  // ====== Controllers ======
  void _controllers() {
    Get.put<AuthController>(
      AuthController(
        authRepo: Get.find<AuthRepository>(),
      ),
      permanent: true,
    );
    Get.put<ProfileController>(
      ProfileController(
        repo: Get.find<ProfileRepository>(),
      ),
      permanent: true,
    );
    Get.lazyPut<CategoryController>(
      () => CategoryController(
        repo: Get.find<CategoryRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<CartController>(
      () => CartController(
        repo: Get.find<CartRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<ProductController>(
      () => ProductController(
        repo: Get.find<ProductRepository>(),
      ),
      fenix: true,
    );
  }
}
