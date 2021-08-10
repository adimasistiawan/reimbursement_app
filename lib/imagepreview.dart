import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  String image;
  ImagePreview({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: NetworkImage(image),
    ));
  }
}
