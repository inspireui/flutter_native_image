import 'dart:io';

import 'flutter_native_image_method_channel.dart';
import 'flutter_native_image_platform_interface.dart';

class FlutterNativeImage {
  Future<File> compressImage(String fileName) {
    return FlutterNativeImagePlatform.instance.compressImage(fileName);
  }

  Future<File> cropImage(
      String fileName, int originX, int originY, int width, int height) {
    return FlutterNativeImagePlatform.instance
        .cropImage(fileName, originX, originY, width, height);
  }

  Future<ImageProperties> getImageProperties(String fileName) {
    return FlutterNativeImagePlatform.instance.getImageProperties(fileName);
  }

  Future<String?> getPlatformVersion() {
    return FlutterNativeImagePlatform.instance.getPlatformVersion();
  }
}
