import 'package:flutter/material.dart';
import 'package:e_commerce/components/cart_button.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/utils/DialogMixin.dart';
import '../../../models/products_model.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductsModel productModel;

  ProductDetailsScreen({
    super.key,
    required this.productModel,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with DialogMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartButton(
        price: widget.productModel.price!,
        press: () {
          listofCartProdut.add(widget.productModel);
          showGetXToast("successfully", 'Your item added to card');
          Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProductImages(
              images: widget.productModel.images!,
            ),
            ProductInfo(
              brand: widget.productModel.category!.name!,
              title: widget.productModel.title!,
              description: widget.productModel.description!,
              rating: 4.4,
              numOfReviews: 126,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
