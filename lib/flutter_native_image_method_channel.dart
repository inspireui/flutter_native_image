import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_image_platform_interface.dart';

/// An implementation of [FlutterNativeImagePlatform] that uses method channels.
class MethodChannelFlutterNativeImage extends FlutterNativeImagePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_image');

  /// Compress an image
  ///
  /// Compresses the given [fileName].
  /// [percentage] controls by how much the image should be resized. (0-100)
  /// [quality] controls how strong the compression should be. (0-100)
  /// Use [targetWidth] and [targetHeight] to resize the image for a specific
  /// target size.

  @override
  Future<File> compressImage(String fileName,
      {int percentage = 70,
      int quality = 70,
      int targetWidth = 0,
      int targetHeight = 0}) async {
    var file = await methodChannel.invokeMethod("compressImage", {
      'file': fileName,
      'quality': quality,
      'percentage': percentage,
      'targetWidth': targetWidth,
      'targetHeight': targetHeight
    });

    return File(file);
  }

  /// Gets the properties of an image
  ///
  /// Gets the properties of an image given the [fileName].
  @override
  Future<ImageProperties> getImageProperties(String fileName) async {
    var properties = Map.from(await (methodChannel
        .invokeMethod("getImageProperties", {'file': fileName})));
    return ImageProperties(
        width: properties["width"],
        height: properties["height"],
        orientation: _decodeOrientation(properties["orientation"]));
  }

  ImageOrientation _decodeOrientation(int? orientation) {
    // For details, see: https://developer.android.com/reference/android/media/ExifInterface
    switch (orientation) {
      case 1:
        return ImageOrientation.normal;
      case 2:
        return ImageOrientation.flipHorizontal;
      case 3:
        return ImageOrientation.rotate180;
      case 4:
        return ImageOrientation.flipVertical;
      case 5:
        return ImageOrientation.transpose;
      case 6:
        return ImageOrientation.rotate90;
      case 7:
        return ImageOrientation.transverse;
      case 8:
        return ImageOrientation.rotate270;
      default:
        return ImageOrientation.undefined;
    }
  }

  /// Crops an image
  ///
  /// Crops the given [fileName].
  /// [originX] and [originY] control from where the image should be cropped.
  /// [width] and [height] control how the image is being cropped.
  @override
  Future<File> cropImage(
      String fileName, int originX, int originY, int width, int height) async {
    var file = await methodChannel.invokeMethod("cropImage", {
      'file': fileName,
      'originX': originX,
      'originY': originY,
      'width': width,
      'height': height
    });

    return File(file);
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

/// Imageorientation enum used for [getImageProperties].
enum ImageOrientation {
  normal,
  rotate90,
  rotate180,
  rotate270,
  flipHorizontal,
  flipVertical,
  transpose,
  transverse,
  undefined,
}

/// Return value of [getImageProperties].
class ImageProperties {
  int? width;
  int? height;
  ImageOrientation orientation;

  ImageProperties(
      {this.width = 0,
      this.height = 0,
      this.orientation = ImageOrientation.undefined});
}
