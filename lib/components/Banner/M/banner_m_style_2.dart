import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../banner_discount_tag.dart';
import 'banner_m.dart';

import '../../../constants.dart';

class BannerMStyle2 extends StatelessWidget {
  const BannerMStyle2({
    super.key,
    this.image = "https://i.imgur.com/J1Qjut7.png",
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
