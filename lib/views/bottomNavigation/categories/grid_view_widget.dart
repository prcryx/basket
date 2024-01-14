import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/cart_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/product_entity.dart';

import 'product_detail_sheet.dart';

class GridViewWidget extends StatefulWidget {
  // final List<Map<String, dynamic>> products;
  final List<ProductEntity>? products;

  const GridViewWidget({this.products, super.key});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  late CartController cartController;

  @override
  void initState() {
    cartController = Get.find<CartController>();
    super.initState();
  }

  // final List<Product> item = [
  @override
  Widget build(BuildContext context) {
    return (widget.products != null || widget.products!.isNotEmpty)
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:
                  0.650, // Adjust the aspect ratio for taller items
            ),
            itemCount: widget.products!.length,
            itemBuilder: (context, index) {
              final product = widget.products![index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (BuildContext context) {
                      return widget.products != null
                          ? ProductDetailsSheet(item: widget.products!.first)
                          : Container(); // Show details for the first product
                    },
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // Handle favorite button press here
                            },
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 12),
                            child: Container(
                              height: 30,
                              width: 50,
                              color: Colors.red[100],
                              // Set the background color to light red
                              child: const Center(
                                child: Text(
                                  "16%",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: product.images != null
                                ? Image.network(
                                    product.images!.first,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Text(
                            '${product.quantity ?? ''}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Text(
                            product.name ?? '',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Text(
                            '${product.price ?? ''}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: IconButton(
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                // Handle calendar button press here
                              },
                            ),
                          ),
                          const Spacer(),
                          Obx(() {
                            int qty = 0, ix = 0;
                            var cartItemsDetails = (cartController
                                            .rxCartItem.value?.cartPoduct !=
                                        null &&
                                    cartController.rxCartItem.value?.cartPoduct
                                            ?.length !=
                                        0)
                                ? cartController.rxCartItem.value!.cartPoduct
                                : null;
                            if (cartItemsDetails != null) {
                              ix = cartItemsDetails
                                  .indexWhere((dt) => dt.sId! == product.sId!);
                              if (ix != -1) {
                                qty = cartItemsDetails[ix].quantity ?? 0;
                              }
                            }

                            return Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (!cartController.rxIsLoading.value) {
                                        cartController.decreaseOps(product.sId);
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  '$qty',
                                  style: const TextStyle(color: Colors.black),
                                ),
                                // Quantity
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      // Handle quantity increase here
                                      if (!cartController.rxIsLoading.value) {
                                        cartController.increaseOps(product.sId);
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Container();
  }
}
