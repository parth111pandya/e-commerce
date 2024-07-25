import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:e_commerce/components/product/product_card.dart';
import 'package:e_commerce/route/screen_export.dart';
import '../../../../api/ApiExecutor.dart';
import '../../../../api/ApiNameConst.dart';
import '../../../../constants.dart';
import '../../../../models/products_model.dart';

class PopularProducts extends StatefulWidget {
  num categoriesId;

  PopularProducts({
    super.key,
    this.categoriesId = -99,
  });

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listofProdutLocallyStore.isNotEmpty
        ? listOfProducts = listofProdutLocallyStore
        : productsApi(context);
  }

  @override
  Widget build(BuildContext context) {
    print("widget.categoriesId::${widget.categoriesId}");
    listOfCategories = listOfProducts;
    widget.categoriesId != -99 && listOfCategories.isNotEmpty
        ? listOfCategories = listOfCategories
            .where(
              (item) => item.category!.id == widget.categoriesId,
            )
            .toList()
        : listOfCategories = listOfProducts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: defaultPadding / 2,
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        listOfCategories.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: (1 / 1.4),
                ),
                itemCount: listOfCategories.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ProductCard(
                    productsModel: listOfCategories[index],
                    image: listOfCategories[index]
                        .images!
                        .first
                        .replaceAll(RegExp(r'^[\["]+|[\]"]+$'), '')
                        .trim(),
                    category: listOfCategories[index].category!.name!,
                    categoryImage: listOfCategories[index].category!.image!,
                    title: listOfCategories[index].title ?? "",
                    price: listOfCategories[index].price ?? 0,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                  productModel: listOfCategories[index],
                                )),
                      );
                    },
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ],
    );
  }

  ApiExecutor apiexecutor = ApiExecutor();

  // bool isproductsApi = true;
  List<ProductsModel> listOfCategories = [];
  List<ProductsModel> listOfProducts = [];

  Future<List<ProductsModel>> productsApi(context) async {
    listOfProducts.clear();
    List<ProductsModel> tempList = [];
    Map<String, String> map = {};
    await apiexecutor.callApi(
      context,
      PRODUCTS,
      false,
      false,
      map,
      (val) {
        // Parse the JSON string
        List<dynamic> jsonList = jsonDecode(val);

        // Convert the JSON list to a list of Item objects
        tempList =
            jsonList.map((json) => ProductsModel.fromJson(json)).toList();
        listOfProducts.addAll(tempList);
        listofProdutLocallyStore = listOfProducts;
        setState(() {});
      },
      true,
    );
    return listOfCategories;
  }
}
