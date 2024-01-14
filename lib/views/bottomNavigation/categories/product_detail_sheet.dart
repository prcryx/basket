
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/product_entity.dart';
import 'package:mr_ambarisha_frontend_new/views/Basket/Basket.dart';

class ProductDetailsSheet extends StatelessWidget {
  final ProductEntity? item;

  const ProductDetailsSheet({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 0.980, // Set the desired height
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Handle favorite button press
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              (item?.images != null || item!.images!.isNotEmpty)
                  ? Image.network(
                      item!.images!.first,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(),
              const SizedBox(height: 16.0),
              Text(
                item?.name ?? "",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '${item?.numOfReviews ?? 0}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${item?.price ?? 0}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              Text(
                '${item?.discountedPrice ?? ''}% off',
                style: const TextStyle(color: Colors.green),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Description:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              Text(
                item?.description ?? '',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      // Handle quantity decrease
                    },
                  ),
                  const Text(
                    '1',
                    style: TextStyle(color: Colors.black),
                  ), // Quantity
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Handle quantity increase
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => Basket());
                    },
                    child: Container(
                      width: 120.0, // Adjust the size as needed
                      height: 60.0, // Adjust the size as needed
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors
                                .black, // You can change the text color as needed
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
