import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/cart_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/category_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/controllers/product_controller.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/cart_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/category_entity.dart';
import 'package:mr_ambarisha_frontend_new/utils/constant_box.dart';
import 'package:mr_ambarisha_frontend_new/views/Basket/Basket.dart';
import 'package:mr_ambarisha_frontend_new/views/bottomNavigation/categories/grid_view_widget.dart';
import 'package:mr_ambarisha_frontend_new/views/bottomNavigation/categories/list_view_widget.dart';

import 'bottom_navigation_view.dart';

class Product {
  final String name;
  final String image;
  final double rating;
  final double price;
  final double discount;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.rating,
    required this.price,
    required this.discount,
    required this.description,
  });
}

class Categories extends StatefulWidget {
  final List<CategoryEntity>? categories;
  const Categories({Key? key, this.categories}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _selectedTabIndex = 0;
  late ProductController productController;
  late CategoryController categoryController;
  late CartController cartController;
  late CategoryEntity? _categoryOnScreen;
  List<CategoryEntity> categories = [];

  @override
  void initState() {
    productController = Get.find<ProductController>();
    categoryController = Get.find<CategoryController>();
    cartController = Get.find<CartController>();
    if (widget.categories != null && widget.categories?.length != 0) {
      categories = widget.categories!;
    } else {
      categories = categoryController.categories ?? [];
    }
    _categoryOnScreen = categories.first;
    productController.getProductsByCategory(_categoryOnScreen?.sId!);

    super.initState();
  }

  final List<Map<String, dynamic>> tabItems = [
    {
      'text': 'Tab 1',
      'image': 'https://picsum.photos/id/237/200/300',
    },
    {
      'text': 'Tab 2',
      'image': 'https://picsum.photos/id/237/200/300',
    },
    {
      'text': 'Tab 3',
      'image': 'https://picsum.photos/200/300',
    },
    {
      'text': 'Tab 4',
      'image': 'https://picsum.photos/200/300',
    },
  ];

  // final List<Map<String, dynamic>> products = [
  //   {
  //     'name': 'Product 1',
  //     'image': 'https://picsum.photos/200',
  //     'size': '1kg',
  //     'price': "200"
  //   },
  //   {
  //     'name': 'Product 2',
  //     'image': 'https://picsum.photos/201',
  //     'size': '500ML',
  //     'price': "200"
  //   },
  //   {
  //     'name': 'Product 3',
  //     'image': 'https://picsum.photos/202',
  //     'size': '2kg',
  //     'price': "200"
  //   },
  // ];
  final List<String> imageList = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    // Add your image URLs or file paths here
  ];
  // int _quantity = 1;
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => const BottomNavigationView());
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => BottomNavigationView()));
        return false;
      },
      child: Scaffold(
        appBar: categoryAppBar(),
        body: Row(
          children: [
            _sideBar(),
            Expanded(
              child: Column(
                children: [
                  _categoryHeader(_categoryOnScreen),
                  _categorySlider(),
                  Obx(() {
                    return Expanded(
                      child: _isGridView
                          ? GridViewWidget(
                              products: productController.rxProductsList.value,
                            )
                          : ListViewWidget(
                              products: productController.rxProductsList.value),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: _viewCartButton(context),
                  ),
                  kbox30()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sideBar() {
    return Container(
      width: 100,
      color: Colors.white,
      child: ListView.builder(
        itemCount: tabItems.length,
        itemBuilder: (context, index) {
          final item = tabItems[index];
          final isSelected = index == _selectedTabIndex;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              color: isSelected ? Colors.lightGreen[200] : Colors.white,
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(item['image'],
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['text'],
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey[500],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _categorySlider() {
    return Center(
      child: CarouselSlider(
        items: categories.map((category) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust the radius as needed
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  // Match the radius with the container
                  child: category.image != null
                      ? CachedNetworkImage(
                          imageUrl: category.image!,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {
              _categoryOnScreen = categories[index];
            });
          },
        ),
      ),
    );
  }

  Widget _viewCartButton(BuildContext context) {
    return Obx(() {
      int totalqty = 0;
      int price = 0;
      if (cartController.rxCartItem.value?.cartPoduct != null) {
        for (CartProduct v in cartController.rxCartItem.value!.cartPoduct!) {
          totalqty += v.quantity ?? 0;
          price += (v.price ?? 0) * (v.quantity ?? 0);
        }
      }
      return GestureDetector(
        onTap: () {
          Get.to(() => Basket());
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.pinkAccent),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  '$totalqty Item  | ₹ $price',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              const Text('view Cart', style: TextStyle(color: Colors.white)),
              kboxw10(),
              const Icon(Icons.shopping_bag)
            ],
          ),
        ),
      );
    });
  }

  Widget _categoryHeader(CategoryEntity? category) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            category?.name ?? '',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.grid_on,
                color: _isGridView ? Colors.black : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isGridView = true;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.view_list,
                color: _isGridView ? Colors.grey : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isGridView = false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  gothomepage() {
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageview()));
    Navigator.pop(context);
  }
}

AppBar categoryAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: Center(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Handle search button press here
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    ),
  );
}
