import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/widgets.dart';
import '../../../constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return listofCartProdut.isNotEmpty
        ? Scaffold(
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: listofCartProdut.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Image.network(
                                  listofCartProdut[index]
                                      .images!
                                      .first
                                      .replaceAll(
                                          RegExp(r'^[\["]+|[\]"]+$'), '')
                                      .trim(),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container();
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return const Text("");
                                  },
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        listofCartProdut[index].title!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        listofCartProdut[index].category!.name!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                listofCartProdut.removeAt(index);
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.cancel,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 2,
                              ),
                              child: Text(
                                "\$${listofCartProdut[index].price}",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: defaultBorderRadious / 2,
                ),
                child: SizedBox(
                  height: 64,
                  child: Material(
                    color: primaryColor,
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultBorderRadious),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white),
                                ),
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            height: double.infinity,
                            color: Colors.black.withOpacity(0.15),
                            child: Text(
                              totalPrice(listofCartProdut),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Center(
            child: Text("No Item Found"),
          );
  }

  String totalPrice(List<ProductsModel> listofCartProdut) {
    num totalPrice = 0;
    for (var element in listofCartProdut) {
      totalPrice = totalPrice + element.price!;
    }

    return "\$$totalPrice";
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
