import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/category_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/category_repo.dart';

class CategoryController extends GetxController {
  CategoryRepository repo;

  CategoryController({required this.repo});

  //Rx vars

  RxList<CategoryEntity>? categories =
      <CategoryEntity>[CategoryEntity(sId: null)].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onReady() async {
    isLoading.value = false;
    await getAllCategory();
    isLoading.value = true;
    super.onReady();
  }


  Future<void> getAllCategory() async {
    try {
      categories?.value = await repo.getAllCategory();
    } catch (e) {
      print("ERRRROOR");
    }
  }
}
