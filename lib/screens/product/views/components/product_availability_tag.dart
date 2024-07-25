import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ProductAvailabilityTag extends StatelessWidget {
  const ProductAvailabilityTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: const BoxDecoration(
        color: successColor,
        borderRadius: BorderRadius.all(
          Radius.circular(defaultBorderRadious / 2),
        ),
      ),
      child: Text(
        "Available in stock",
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
