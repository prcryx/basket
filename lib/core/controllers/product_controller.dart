import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/product_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/product_repo.dart';

class ProductController extends GetxController {
  ProductRepository repo;
  ProductController({required this.repo});

  //Rx vars
  Rx<List<ProductEntity>?> rxProductsList = Rx<List<ProductEntity>?>([]);

  void getProductsByCategory(String? categoryId) async {
    try {
      if (categoryId != null) {
        rxProductsList.value =
            await repo.getProductsByCategory(categoryId) ?? [];
        print("DOOOOOOONE");
      }
    } catch (e) {}
  }
}
