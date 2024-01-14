import 'package:mr_ambarisha_frontend_new/core/domain/models/category_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_client.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_endpoint.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategory();
}

class CategoryRepositoryImpl implements CategoryRepository {
  final ApiClient apiClient;
  const CategoryRepositoryImpl({required this.apiClient});
  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    final res = await apiClient.get(ApiEndpoints.categories);
    return res['categories']
        .map<CategoryEntity>((x) => CategoryEntity.fromJson(x))
        .toList();
  }
}
