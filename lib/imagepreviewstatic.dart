import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewStatic extends StatelessWidget {
  File image;
  ImagePreviewStatic({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: FileImage(image),
    ));
  }
}
