import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'categories.dart';
import 'offers_carousel.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  Function callback;

  OffersCarouselAndCategories({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OffersCarousel(),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Categories",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Categories(
          callBack: callback,
        ),
      ],
    );
  }
}
