import 'package:mr_ambarisha_frontend_new/core/domain/models/product_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_client.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_endpoint.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>?> getProductsByCategory(String categoryId);
}

class ProductRepositoryImpl implements ProductRepository {
  ApiClient apiClient;
  ProductRepositoryImpl({required this.apiClient});
  @override
  Future<List<ProductEntity>?> getProductsByCategory(String categoryId) async {
    final res =
        await apiClient.get('${ApiEndpoints.productByCategory}/$categoryId');
    return res['data']
        .map<ProductEntity>((x) => ProductEntity.fromJson(x))
        .toList();
  }
}
