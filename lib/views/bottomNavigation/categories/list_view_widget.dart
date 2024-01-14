import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/cart_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/product_entity.dart';

import 'product_detail_sheet.dart';

class ListViewWidget extends StatefulWidget {
  final List<ProductEntity>? products;

  const ListViewWidget({this.products, super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  // final List<Product> item = [
  //   Product(
  //     name: 'Product 1',
  //     image: 'https://picsum.photos/200/300',
  //     rating: 4.5,
  //     price: 25.0,
  //     discount: 10.0,
  //     description: 'Description of Product 1',
  //   ),
  //   // Add more products here
  // ];

  late CartController cartController;

  @override
  void initState() {
    cartController = Get.find<CartController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.products?.length != 0
            ? showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (BuildContext context) {
                  return widget.products != null
                      ? ProductDetailsSheet(item: widget.products!.first)
                      : Container(); // Show details for the first product
                },
              )
            : null;
      },
      child: widget.products != null
          ? ListView.builder(
              itemCount: widget.products!.length,
              itemBuilder: (context, index) {
                final product = widget.products![index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: product.images != null
                            ? Image.network(
                                product.images!.first,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? '',
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Size: ${product.quantity}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                            Text(
                              'price: ${product.price}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 40,
                            child: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                // Handle calendar button press here
                              },
                            ),
                          ),
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
                              ix = cartItemsDetails.indexWhere((dt) =>
                                  dt.cartProductDetails!.sId == product.sId!);
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
                                      cartController.decreaseOps(product.sId!);
                                    },
                                  ),
                                ),

                                Text(
                                  qty.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),

                                // Quantity
                                SizedBox(
                                  width: 40,
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cartController.increaseOps(product.sId!);
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
                );
              },
            )
          : Container(),
    );
  }
}
