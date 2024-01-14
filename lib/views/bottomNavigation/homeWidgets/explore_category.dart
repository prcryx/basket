import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/category_controller.dart';

import '../Categories.dart';

class ExploreCategoryView extends StatelessWidget {
  final CategoryController controller = Get.find<CategoryController>();
  ExploreCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 100,
        childAspectRatio: 2 / 3.7,
      ),
      itemCount: controller.categories?.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(() => const Categories());
          },
          child: Obx(() {
            return controller.categories != null || controller.isLoading.value
                ? Column(
                    children: [
                      if (controller.categories![index].image != null) ...[
                        CachedNetworkImage(
                          imageUrl: controller.categories![index].image ?? '',
                          errorWidget: (context, url, error) => Container(),
                        )
                      ],
                      const SizedBox(height: 10),
                      Text(
                        controller.categories![index].name ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator();
          }),
        );
      },
    );
  }

  // List shopbycategory = [
  //   "assets/gerocery1.png",
  //   "assets/gerocery2.png",
  //   "assets/milk.png",
  //   "assets/personlcare.png",
  //   "assets/milk.png",
  //   "assets/gerocery1.png",
  //   "assets/gerocery2.png",
  //   "assets/milk.png",
  //   "assets/personlcare.png",
  //   "assets/milk.png",
  //   "assets/gerocery1.png",
  //   "assets/gerocery2.png",
  //   "assets/milk.png",
  //   "assets/personlcare.png",
  //   "assets/milk.png",
  // ];
  // List shopbycategorytext = [
  //   "Grocery",
  //   "Frozen\nFood",
  //   "Vegetables",
  //   "Personal\nCare",
  //   "Milk",
  //   "Grocery",
  //   "Frozen\nFood",
  //   "Vegetables",
  //   "Personal\nCare",
  //   "Milk",
  //   "Grocery",
  //   "Frozen\nFood",
  //   "Vegetables",
  //   "Personal\nCare",
  //   "Milk",
  // ];
}
