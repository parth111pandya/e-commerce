import 'package:flutter/material.dart';
import 'banner_m.dart';

import '../../../constants.dart';

class BannerMStyle1 extends StatelessWidget {
  const BannerMStyle1({
    super.key,
    this.image = "https://i.imgur.com/UP7xhPG.png",
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      children: [],
    );
  }
}
