import 'package:app/constants/assets_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/theme/pallet.dart';
import 'package:flutter/material.dart';

class UIConstants {
  static AppBar appBar () {
    return AppBar(
        title: SvgPicture.asset(
            AssetsConstants.twitterLogo,
            color: Pallet.blueColor,
          height: 30,
        ),
      centerTitle: true,
    );
  }
}