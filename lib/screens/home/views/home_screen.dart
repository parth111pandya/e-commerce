import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  callback(num val) {
    categoriesId = val;
    setState(() {});
  }

  num categoriesId = -99;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: OffersCarouselAndCategories(
                callback: this.callback,
              ),
            ),
            SliverToBoxAdapter(
              child: PopularProducts(
                categoriesId: categoriesId,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
