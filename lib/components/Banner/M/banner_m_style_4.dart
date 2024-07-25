import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'banner_m.dart';

import '../../../constants.dart';

class BannerMStyle4 extends StatelessWidget {
  const BannerMStyle4({
    super.key,
    this.image = "https://i.imgur.com/R4iKkDD.png",
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
