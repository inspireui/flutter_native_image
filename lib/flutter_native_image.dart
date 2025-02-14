import 'dart:io';

import 'flutter_native_image_method_channel.dart';
import 'flutter_native_image_platform_interface.dart';

class FlutterNativeImage {
  static Future<File> compressImage(
    String fileName, {
    int percentage = 70,
    int quality = 70,
    int targetWidth = 0,
    int targetHeight = 0,
  }) {
    return FlutterNativeImagePlatform.instance.compressImage(
      fileName,
      percentage: percentage,
      quality: quality,
      targetWidth: targetWidth,
      targetHeight: targetHeight,
    );
  }

  static Future<File> cropImage(
      String fileName, int originX, int originY, int width, int height) {
    return FlutterNativeImagePlatform.instance
        .cropImage(fileName, originX, originY, width, height);
  }

  static Future<ImageProperties> getImageProperties(String fileName) {
    return FlutterNativeImagePlatform.instance.getImageProperties(fileName);
  }

  static Future<String?> getPlatformVersion() {
    return FlutterNativeImagePlatform.instance.getPlatformVersion();
  }
}
