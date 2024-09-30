import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/util/helper.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? url;
  final String? placeHolderImg;
  Color? placeHolderImgColor;
  final double? width;
  double? height;
  String? screenName;
  BoxFit? fit;
  bool? isBoxFit;
  bool? isNewSize;

  CustomCachedNetworkImage(
      {this.url,
      this.placeHolderImg,
      this.placeHolderImgColor,
      this.width,
      this.height=100,
      this.screenName,
      this.fit,
      this.isNewSize,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CachedNetworkImage(
        imageUrl: "$url",
        fit: fit ?? BoxFit.fill,
        width: screenWeight(),
        height: height,
        placeholder: (context, url) =>
            Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNNLEL-qmmLeFR1nxJuepFOgPYfnwHR56vcw&s'),
        errorWidget: (context, url, error) =>
            Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNNLEL-qmmLeFR1nxJuepFOgPYfnwHR56vcw&s'),
      ),
    );
  }
}
