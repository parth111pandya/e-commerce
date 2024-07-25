import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/products_model.dart';
import '../../utils/DialogMixin.dart';

class ProductCard extends StatelessWidget with DialogMixin {
  const ProductCard({
    super.key,
    required this.image,
    required this.categoryImage,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
    required this.press,
    required this.category,
    required this.productsModel,
  });

  final String image, title;
  final num price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  final VoidCallback press;
  final String categoryImage;
  final String category;
  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(140, 220),
        maximumSize: const Size(140, 220),
        padding: const EdgeInsets.all(8),
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container();
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Text("");
                },
                width: double.maxFinite,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                category,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge!,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "\$$price",
                    style: const TextStyle(
                      color: Color(0xFF31B0D8),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    listofCartProdut.add(productsModel);
                    showGetXToast("successfully", 'Your item added to card');
                  },
                  child: const Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Color(0xFF31B0D8),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
