import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'banner_m.dart';

import '../../../constants.dart';

class BannerMStyle3 extends StatelessWidget {
  const BannerMStyle3({
    super.key,
    this.image = "https://i.imgur.com/8REExBV.png",
  });
  final String? image;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      children: [
      ],
    );
  }
}
